
$: << File.join(File.dirname(__FILE__), "../lib")

require 'test/unit'
require 'multimarkdown'
require_relative 'test_writer'

class MemoirSuiteTest < Test::Unit::TestCase
  
  # dynamically create the test functions based on the source files
  build_tests("MemoirTests", {:exclude_exts => ["html"]})
end

