require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "invoicepdf"
  gem.homepage = "http://github.com/drewtempelmeyer/invoicepdf"
  gem.license = "MIT"
  gem.summary = %Q{Easily create PDF invoices}
  gem.description = %Q{Easily create PDF invoices}
  gem.email = "drewtemp@gmail.com"
  gem.authors = ["Drew Tempelmeyer"]
  gem.add_runtime_dependency 'prawn'
  gem.files = FileList['Rakefile', 'lib/**/*.rb', 'init.rb']
  gem.rubyforge_project = 'invoicepdf'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "invoicepdf #{version}"
  rdoc.options << '-f' << 'horo'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
