module InvoicePDF
  # Helpers to be used in InvoicePDF::Generators
  module Helpers
    
    # Similar to Rails' number_to_currency, but we don't want to rely on Rails.
    # Found the majority of this code online, but lost the URL. If this is yours, let me know and I'll give
    # credit.
    #
    # Formats the +number+ into a currency format. You can customize the format in the +options+ hash.
    #
    # ==== Options
    # * <tt>:currency_symbol</tt> - Currency symbol. (default is '$')
    # * <tt>:delimiter</tt>       - Thousands separator. (default is ',')
    # * <tt>:decimal_symbol</tt>  - Separates integer and fractional amounts (think dollars and cents). (default is '.')
    # * <tt>:currency_before</tt> - Boolean to set placement of <tt>:currency_symbol</tt>. true for before number, false for after number. (default is true)
    # * <tt>:after_text</tt>      - Useful for displaying the currency after the number. (default is ' USD')
    #
    # ==== Example
    #  money_maker(1000)     # => $1,000.00 USD
    #  money_maker(1000, :delimiter => '.', :decimal_symbol => ',', :after_text => '')    # => $1.000,00
    def money_maker( number, options = {} )
      options = { :currency_symbol => '$', :delimiter => ',', :decimal_symbol => '.', :currency_before => true, :after_text => ' USD' }.merge(options)
      
      # split integer and fractional parts
      int, frac = ("%.2f" % number).split('.')
      
      # insert delimiters
      int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")
      
      return options[:currency_symbol] + int + options[:decimal_symbol] + frac + options[:after_text] if options[:currency_before]
      int + options[:decimal_symbol] + frac + options[:currency_symbol] + options[:after_text]
    end
  end
end