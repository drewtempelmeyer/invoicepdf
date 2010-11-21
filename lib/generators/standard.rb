module InvoicePDF
 
  # Generators should be contained within the <tt>InvoicePDF::Generators</tt> module.
  module Generators
    
    # The default InvoicePDF generator.
    class Standard
      include InvoicePDF::Helpers
      
      # Constructor here for future use... maybe.
      def initialize( options = {} ); end
      
      # Called from <tt>InvoicePDF::Invoice.save</tt>. +invoice+ is the <tt>InvoicePDF::Invoice</tt> instance.
      def create_pdf( invoice )
        money_maker_options = {
          :currency_symbol => invoice.currency,
          :delimiter => invoice.separator,
          :decimal_symbol => invoice.decimal,
          :after_text => invoice.currency_text
        }
        
        # The below line should remain consistent across all generators. We don't want mysteriously placed PDF files.
        Prawn::Document.generate("#{invoice.file_path}/#{invoice.file_name}", :dpi => 72) do |pdf|
          pdf.move_down 10
          
          # Set the default type
          pdf.font 'Helvetica', :size => 9
          
          # Draw the company name
          pdf.text invoice.company, :style => :bold, :size => 20
          
          # Invoice information
          pdf.bounding_box [ pdf.bounds.right - 200, pdf.bounds.top - 2 ], :width => 250 do
            data = [
              [ { :text => 'Invoice Number', :font_style => :bold }, invoice.number ],
              [ { :text => 'Invoice Date', :font_style => :bold }, invoice.invoice_date ],
              [ { :text => 'Due Date', :font_style => :bold }, invoice.due_date ]
            ]
            
            data.insert( 1, [ { :text => 'PO Number', :font_style => :bold }, invoice.po_number ] ) unless invoice.po_number.nil?
            
            pdf.table data,
              :border_style => :underline_header,
              :font_size => 9,
              :horizontal_padding => 2,
              :vertical_padding => 1,
              :column_widths => { 0 => 100, 1 => 150 },
              :position => :left,
              :align => { 0 => :left, 1 => :left }
          end
          # End bounding_box
          
          pdf.move_down 65
          
          var_y = pdf.y
          
          # Bill to section
          pdf.bounding_box [ 0, var_y ], :width => ( pdf.bounds.right / 3 ) do
            pdf.text 'Bill To', :style => :bold
            pdf.text "#{invoice.bill_to}\n#{invoice.bill_to_address}"
          end
          # End bill to section
          
          # Company address section
          pdf.bounding_box [ ( pdf.bounds.right / 3 ), var_y ], :width => ( pdf.bounds.right / 3 ) do
            pdf.text 'Pay To', :style => :bold
            pdf.text "#{invoice.company}\n#{invoice.company_address}"
          end
          # End company address section
          
          pdf.move_down 40
          
          # Create items array for storage of invoice items
          items = []
          invoice.items.map { |item| items << [ item.description, item.quantity, money_maker(item.price, money_maker_options), money_maker(item.total, money_maker_options) ] }
          
          # Insert subtotal
          items << [ { :text => 'Subtotal', :align => :right, :colspan => 3 }, money_maker(invoice.subtotal, money_maker_options) ]
          
          # Insert discount
          items << [ { :text => "Discount (#{invoice.discount}%)", :align => :right, :colspan => 3 }, money_maker(invoice.discount_amount, money_maker_options) ] if invoice.discount_amount > 0
          
          # Insert tax amount
          items << [ { :text => "Tax (#{invoice.tax}%)", :align => :right, :colspan => 3 }, money_maker(invoice.tax_amount, money_maker_options) ] if invoice.tax_amount > 0
          
          # Insert total
          items << [ { :text => "Total", :align => :right, :colspan => 3 }, money_maker(invoice.total, money_maker_options) ]
          
          # Insert amount paid
          items << [ { :text => "Amount Paid", :align => :right, :colspan => 3 }, money_maker(invoice.paid, money_maker_options) ] if invoice.paid > 0
          
          # Insert total due
          items << [ { :text => "Amount Due", :align => :right, :colspan => 3, :font_style => :bold }, money_maker(invoice.total_due, money_maker_options) ]
          
          # Create items table
          pdf.table items,
            :border_style => :underline_header,
            :border_width => 0,
            :border_color => '000000',
            :font_size => 9,
            :headers => [
              { :text => 'Description', :font_style => :bold },
              { :text => 'Qty', :font_style => :bold },
              { :text => 'Price', :font_style => :bold },
              { :text => 'Total', :font_style => :bold }
            ],
            :header_color => '000000',
            :header_text_color => 'ffffff',
            :align => { 0 => :left, 1 => :center, 2 => :center, 3 => :right },
            :row_colors => [ 'ffffff', 'f0f0f0' ],
            :width => pdf.bounds.right,
            :column_widths => { 1 => 50, 2 => 75, 3 => 75 }
          
          unless invoice.notes.nil?
            pdf.move_down 50
            pdf.text 'Notes', :size => 10, :style => :bold
            pdf.text invoice.notes, :size => 8
          end
        end
        # Done creating PDF
        
      end
      
    end
    
  end
end