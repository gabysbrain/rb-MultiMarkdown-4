
$: << File.join(File.dirname(__FILE__), "../lib")

require 'test/unit'

require 'multimarkdown-cli'

class TiltIntegrationSuiteTest < Test::Unit::TestCase
  
  def test_registered_extension
    assert_equal MultiMarkdownCLI::Template, Tilt['test.multimarkdown']
  end
end

