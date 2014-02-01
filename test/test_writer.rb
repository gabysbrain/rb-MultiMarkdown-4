
BASE_TEST_DIR = File.absolute_path(File.join(File.dirname(__FILE__), "MMD-Test-Suite"))

EXT_MAP = {
  'tex' => 'latex',
  'fodt' => 'odf'
}

def build_tests(subdir, use_tidy: false, exclude_exts: [], ext_map: {}, options: [])
  # merge the extension map
  ext_map = EXT_MAP.merge(ext_map)

  test_dir = File.join(BASE_TEST_DIR, subdir)
  Dir.glob(File.join(test_dir, "*.text")).each do |source|
    test_rawname = File.basename(source, ".text")
    test_targets = Dir.glob(File.join(test_dir, test_rawname+".*"))
    test_targets.select! {|fname| not fname.end_with?(".text")}
    target_formats = test_targets.map {|fn| File.extname(fn)[1..-1]}
    exclude_exts.each do |ext|
      target_formats.select! {|tgt| tgt != ext}
    end
    target_formats.each do |target|
      test_name = test_rawname.gsub(" ", "_").gsub(',', '').downcase
      test_name = "test_#{test_name}_to_#{target}"
      target_file = test_rawname + '.' + target

      # filter some of the target => extension maps
      target = if ext_map.include? target
        ext_map[target] 
      else
        target
      end 

      # test code is here
      define_method(test_name) do 
        orig_dir = Dir.pwd
        Dir.chdir(File.join(BASE_TEST_DIR, subdir))
        source_txt = File.read(source)
        target_txt = File.read(target_file)
        parser = MultiMarkdown::Parser.new(source_txt, *options)

        parsed_src = parser.convert(target)

        # clean up both outputs
        target_txt.gsub!(/\s+\z/, "")
        parsed_src.gsub!(/\s+\z/, "")
        if use_tidy
          tidy_cmd = "tidy --show-body-only 1 --quiet 1 --show-warnings 0"
          target_txt, status = Open3.capture2(tidy_cmd, :stdin_data=> target_txt)
          parsed_src, status = Open3.capture2(tidy_cmd, :stdin_data=> parsed_src)
        end

        Dir.chdir(orig_dir)
        assert_equal(target_txt, parsed_src)
      end
    end
  end
end
