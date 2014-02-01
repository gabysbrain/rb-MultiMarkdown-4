
$: << File.join(File.dirname(__FILE__), "../lib")

require 'test/unit'
require 'multimarkdown'

class BeamerSuiteTest < Test::Unit::TestCase
  
  BASE_TEST_DIR = File.absolute_path(File.join(File.dirname(__FILE__), "MMD-Test-Suite"))

  # dynamically create the test functions based on the source files
  subdir = "BeamerTests"
  Dir.chdir(File.join(BASE_TEST_DIR, subdir))
  Dir.glob("*.text").each do |source|
    test_rawname = File.basename(source, ".text")
    test_targets = Dir.glob(test_rawname+".*")
    test_targets.select! {|fname| !fname.end_with?(".text")}
    target_formats = test_targets.map {|fn| File.extname(fn)[1..-1]}
    target_formats.select! {|tgt| tgt != "html"} #mmd doesn't test this
    target_formats.each do |target|
      test_name = test_rawname.gsub(" ", "_").downcase
      test_name = "test_#{test_name}_to_#{target}"
      target_file = test_rawname + '.' + target

      # filter some of the target => extension maps
      target = case target
      when "tex"
        "beamer"
      when "fodt"
        "odf"
      else
        target
      end

      # test code is here
      define_method(test_name) do 
        source_txt = File.read(source)
        target_txt = File.read(target_file)
        parser = MultiMarkdown::Parser.new(source_txt)
        assert_equal(target_txt, parser.convert(target))
      end
    end
  end

end

