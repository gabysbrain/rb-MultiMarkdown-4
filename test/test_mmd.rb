
$: << File.join(File.dirname(__FILE__), "../lib")

require 'test/unit'
require 'multimarkdown'
require_relative 'test_writer'

class MultiMarkdownSuiteTest < Test::Unit::TestCase
  
  # dynamically create the test functions based on the source files
  build_tests("MultiMarkdownTests")

end

