
require 'tilt' unless defined? Tilt

require 'multimarkdown-cli'

module MultiMarkdownCLI
  class Template < Tilt::Template

    def self.engine_initialized?
      require 'multimarkdown-cli'
    end

    def initialize_engine
    end

    def prepare
      @source = data
    end

    def evaluate(scope, locals, &block)
      parser = MultiMarkdownCLI::Parser.new(@source, :snippet)
      parser.to_html
    end

    def allows_script?
      false
    end
  end

  Tilt.register Template, 'multimarkdown', 'mmd'
end


