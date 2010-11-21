module InvoicePDF
  # InvoicePDF version
  VERSION = "0.1.2"
end

require 'prawn'
require 'prawn/layout'
require 'invoice/invoice'
require 'invoice/line_item'
require 'invoice/helpers'

Dir[File.dirname(__FILE__) + '/generators/*.rb'].each { |file| require file }