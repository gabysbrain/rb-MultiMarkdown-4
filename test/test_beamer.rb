
$: << File.join(File.dirname(__FILE__), "../lib")

require 'test/unit'
require 'multimarkdown-cli'
require_relative 'mmd_test_suite_builder'

class BeamerSuiteTest < Test::Unit::TestCase
  
  # dynamically create the test functions based on the source files
  build_tests("BeamerTests", {:exclude_exts => ["html"], :ext_map => {'tex'=>'beamer'}})
end

