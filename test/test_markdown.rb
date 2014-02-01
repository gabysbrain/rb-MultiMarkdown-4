
$: << File.join(File.dirname(__FILE__), "../lib")

require 'test/unit'
require 'multimarkdown-cli'
require_relative 'test_writer'

class MarkdownSuiteTest < Test::Unit::TestCase
  
  # dynamically create the test functions based on the source files
  build_tests("Tests", {:use_tidy => true, :options => [:compatibility]})
end

