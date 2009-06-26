# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{captured}
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christopher Sexton"]
  s.date = %q{2009-06-26}
  s.default_executable = %q{captured}
  s.email = %q{csexton@gmail.com}
  s.executables = ["captured"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    "README.markdown",
     "bin/captured",
     "etc/captured.yml-example",
     "etc/launchd.plist.erb",
     "lib/captured.rb",
     "lib/captured/file_tracker.rb",
     "lib/captured/file_uploader.rb",
     "lib/captured/fs_events.rb",
     "resources/captured.png",
     "resources/green_check.png",
     "resources/red_star.png",
     "resources/red_x.png",
     "resources/ruby.png",
     "spec/captured_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/csexton/captured}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{captured}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Quick screenshot sharing for OS X}
  s.test_files = [
    "spec/captured_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-scp>, [">= 0"])
    else
      s.add_dependency(%q<net-scp>, [">= 0"])
    end
  else
    s.add_dependency(%q<net-scp>, [">= 0"])
  end
end
