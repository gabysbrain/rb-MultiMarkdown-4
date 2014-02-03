
$: << File.join(File.dirname(__FILE__), "../lib")

require 'test/unit'

class ModuleSuiteTest < Test::Unit::TestCase
  
  # make sure the module throws an exception on import if 
  # the multimarkdown command can't be found
  def test_import_exception
    # blow out the path so that the command won't be found
    old_path = ENV['PATH']
    begin
      ENV['PATH'] = ''
      assert_raise LoadError do
        require 'multimarkdown-cli'
      end
    ensure
      ENV['PATH'] = old_path
    end
  end
end

