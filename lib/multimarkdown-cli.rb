require "multimarkdown-cli/version"
require "multimarkdown-cli/tilt_plugin"

module MultiMarkdownCLI
  def self._cli_installed?
    # from http://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    mmd_cmd_found = false
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      exts.each do |ext|
        exe = File.join(path, "multimarkdown#{ext}")
        if File.executable? exe
          mmd_cmd_found = true
          break
        end
      end
    end
    mmd_cmd_found
  end

  # check that the command line tool is installed when requiring
  unless _cli_installed?
    raise LoadError.new("Can't find the multimarkdown command in your path.  Please install it")
  end


  class Parser
    attr_reader :source

    attr_accessor :compatibility

    attr_accessor :snippet

    def initialize(source, *options)
      @source = source

      @compatibility = false
      @snippet = false
      options.each {|o| send("#{o}=", true)}
    end
    def convert(format)
      cmd = "multimarkdown"
      cmd += " -c" if @compatibility
      cmd += " -s" if @snippet
      require 'open3'
      stdout, stderr, status = Open3.capture3("#{cmd} -t #{format}", 
                                              :stdin_data=>@source)
      if status.exitstatus != 0
        raise stderr
      end
      stdout
    end
    def to_html
      self.convert("html")
    end
  end
end
