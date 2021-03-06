# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{invoicepdf}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Drew Tempelmeyer"]
  s.date = %q{2010-11-21}
  s.description = %q{Easily create PDF invoices}
  s.email = %q{drewtemp@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "Rakefile",
    "init.rb",
    "lib/generators/standard.rb",
    "lib/invoice/helpers.rb",
    "lib/invoice/invoice.rb",
    "lib/invoice/line_item.rb",
    "lib/invoicepdf.rb"
  ]
  s.homepage = %q{http://github.com/drewtempelmeyer/invoicepdf}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{invoicepdf}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Easily create PDF invoices}
  s.test_files = [
    "test/helper.rb",
    "test/test_invoice.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<prawn>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<horo>, [">= 0"])
      s.add_runtime_dependency(%q<prawn>, [">= 0"])
    else
      s.add_dependency(%q<prawn>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<horo>, [">= 0"])
      s.add_dependency(%q<prawn>, [">= 0"])
    end
  else
    s.add_dependency(%q<prawn>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<horo>, [">= 0"])
    s.add_dependency(%q<prawn>, [">= 0"])
  end
end

