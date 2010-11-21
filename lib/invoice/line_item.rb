module InvoicePDF #:nodoc#
  # Line items for InvoicePDF::Invoice
  class LineItem    
    attr_accessor :sku, :description, :price, :quantity, :taxable
    
    # Creates a new <tt>LineItem</tt> to be added to the InvoicePDF::Invoice instance
    #
    # ==== Options
    # * <tt>:sku</tt>         - SKU of the item. (default is nil)
    # * <tt>:description</tt> - Description of the item. (default is nil)
    # * <tt>:price</tt>       - Price of each item. (default is 0.00)
    # * <tt>:quantity</tt>    - Number of items. (default is 1)
    # * <tt>:taxable</tt>     - Is the item taxable? true/false. (default is false)
    #
    # ==== Example
    #  item = InvoicePDF::InvoiceItem.new(:description => "Test line item", :price => 495.00, :quantity => 5)
    def initialize(options = {})
      options = { :sku => nil, :description => nil, :quantity => 1, :price => 0.00, :taxable => false }.merge(options)
      options.each { |k, v| send("#{k}=", v) }
    end
    
    # Asks if the item is taxable
    #  item = InvoicePDF::InvoiceItem.new(:description => "Test line item", :price => 495.00, :quantity => 5)
    #  item.taxable? # => false
    def taxable?
      return false if taxable.nil? || taxable == false
      true
    end
    
    # Return the total amount of the <tt>LineItem</tt>
    #  item = InvoicePDF::InvoiceItem.new(:description => "Test line item", :price => 495.00, :quantity => 5)
    #  item.total # => 2475
    def total
      price * quantity
    end
    
  end
end