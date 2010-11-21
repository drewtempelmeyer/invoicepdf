require 'helper'

class TestInvoice < Test::Unit::TestCase
  
  should "start a new invoice" do
    invoice = InvoicePDF::Invoice.new(:company => 'Drew Tempelmeyer', :bill_to => 'Alyssa Smith', :notes => 'Pay up now, sucka')
    assert_equal 'Drew Tempelmeyer', invoice.company
  end
  
  should "insert a new item into the invoice" do
    invoice = InvoicePDF::Invoice.new({ :company => 'Drew Tempelmeyer', :bill_to => 'Alyssa Smith', :notes => 'Pay up now, sucka' })
    invoice.items << InvoicePDF::LineItem.new({ :description => 'This is a line item', :price => 400, :quantity => 100 })
    assert_equal 1, invoice.items.length
  end
  
  should "subtotal should equal 40000" do
    invoice = InvoicePDF::Invoice.new({ :company => 'Drew Tempelmeyer', :bill_to => 'Alyssa Smith', :notes => 'Pay up now, sucka' })
    invoice.items << InvoicePDF::LineItem.new({ :description => 'This is a line item', :price => 400, :quantity => 100 })
    assert_equal 40000, invoice.subtotal
  end
  
  should "have paid half of the invoice" do
    invoice = InvoicePDF::Invoice.new({ :company => 'Drew Tempelmeyer', :bill_to => 'Alyssa Smith', :notes => 'Pay up now, sucka' })
    invoice.items << InvoicePDF::LineItem.new({ :description => 'This is a line item', :price => 400, :quantity => 100 })
    invoice.paid = 20000
    assert_equal 20000, invoice.total_due
  end
  
  should "save the PDF" do
    invoice = InvoicePDF::Invoice.new({ :company => 'Drew Tempelmeyer', :bill_to => 'Alyssa Smith', :notes => 'Pay up now, sucka' })
    invoice.items << InvoicePDF::LineItem.new({ :description => 'This is a line item', :price => 400, :quantity => 100 })
    invoice.paid = 20000
    invoice.save
    assert_equal true, File.exist?('invoice.pdf')
  end
  
end
