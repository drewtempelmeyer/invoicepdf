
# One module to rule them all
module InvoicePDF
  
  # Invoice model to create your PDF invoices.
  class Invoice
    
    attr_accessor :generator, :file_name, :file_path, :company, :company_address, :bill_to, :bill_to_address, :invoice_date, :due_date,
                  :number, :po_number, :items, :tax, :discount, :paid, :notes, :currency, :separator, :decimal, :currency_text
    
    # Creates a new Invoice object with the specified options
    # ==== Options
    # * <tt>:generator</tt>        - An <tt>InvoicePDF::Generator</tt> that designs and creates the PDF. (default is InvoicePDF::Generators::Standard.new)
    # * <tt>:file_path</tt>        - The directory to store the generated invoice. (default is './')
    # * <tt>:file_name</tt>        - The file name of the PDF to save. (default is 'invoice.pdf')
    # * <tt>:company</tt>          - The company name that will appear on the top of the invoice and in the 'Bill To' section. (default is 'Company Name')
    # * <tt>:company_address</tt>  - Your company's address. Displayed in the 'Pay To' section. Use \n for line separation. (default is nil)
    # * <tt>:bill_to</tt>          - Person/company you're billing. (default is nil)
    # * <tt>:bill_to_address</tt>  - Address of the person/company you're billing to. Displayed in the 'Bill To' section. (default is nil)
    # * <tt>:number</tt>           - The invoice number. (default is '100')
    # * <tt>:po_number</tt>        - The purchase order number for the invoice. Excluded from the invoice if nil. (default is nil)
    # * <tt>:invoice_date</tt>     - The invoice date. (default is Time.now)
    # * <tt>:due_date</tt>         - The invoice due_date. You need your money by this time. (default is 15 days after Time.now)
    # * <tt>:items</tt>            - Array of <tt>LineItem</tt>s. (default is an empty array).
    # * <tt>:discount</tt>         - Discount to apply to the invoice. The value should not include the percent symbol. (default is nil)
    # * <tt>:tax</tt>              - Tax amount to apply to taxable <tt>LineItem</tt>s. The value should not include the percent symbol. (default is nil)
    # * <tt>:paid</tt>             - The amount already paid on the invoice. (default is 0)
    # * <tt>:notes</tt>            - Notes to display at the end of the invoice. (default is nil)
    # * <tt>:currency</tt>         - The currency symbol to use for formatting prices and totals. (default is '$')
    # * <tt>:separator</tt>        - The thousands separator for prices/totals. (default is ',')
    # * <tt>:decimal</tt>          - The separator between the integer and fractional value. Think dollars and cents. (default is '.')
    # * <tt>:currency_text</tt>    - Displays text after the formatted currency. Useful if you wanted to include the currency code (example: ' USD'). (default is '')
    #
    # ==== Examples
    #  invoice = InvoicePDF::Invoice.new( :company => "Drew Tempelmeyer", :company_address => "555 55th St\nNew York, NY 00000", :bill_to => "John Doe", :number => "AZ-100", :notes => "Test invoice")
    #  invoice.items << InvoicePDF::LineItem.new(:description => "Here is a line item", :price => 495.00, :quantity => 5)
    #  invoice.save
    def initialize( options = {} )
      options = { :generator => InvoicePDF::Generators::Standard.new, :file_path => './', :file_name => 'invoice.pdf', :company => 'Company Name', :number => '100',
        :po_number => nil, :invoice_date => Time.now, :due_date => Time.now + ((60 * 60 * 24) * 15), :items => [], :discount => nil, :tax => nil, :paid => 0,
        :notes => nil, :currency => '$', :separator => ',', :decimal => '.', :currency_text => '' }.merge(options)
      options.each { |k,v| send("#{k}=", v) }
    end
    
    # Calculates the subtotal of the invoice
    def subtotal
      amount = 0
      items.each { |item| amount += item.total }
      amount
    end
    
    # Calculates the tax amount of the invoice based on taxable items
    def tax_amount
      return 0 if tax.nil? || tax <= 0
      amount = 0
      items.each { |item| amount += item.total if item.taxable? }
      amount * ( tax / 100 )
    end
    
    # Calculates the discount amount if a discount is specified greater than 0
    def discount_amount
      return 0 if discount.nil? || discount <= 0
      subtotal * ( discount / 100 )
    end
    
    # Calculates the total of the invoice with the discount and tax amount applied
    def total
      (subtotal - discount_amount) + tax_amount
    end
    
    # The total amount due (total - paid)
    def total_due
      total - paid
    end
    
    # Generates the PDF invoice and saves it to the specified destination
    def save
      generator.create_pdf( self )
    end
    
  end
end