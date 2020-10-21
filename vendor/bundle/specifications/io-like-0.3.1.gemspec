# -*- encoding: utf-8 -*-
# stub: io-like 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "io-like"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jeremy Bopp", "Jarred Holman", "Grant Gardner", "Jordan Pickwell"]
  s.date = "2020-02-09"
  s.description = "The IO::Like module provides all of the methods of typical IO implementations\nsuch as File; most importantly the read, write, and seek series of methods.  A\nclass which includes IO::Like needs to provide only a few methods in order to\nenable the higher level methods.  Buffering is automatically provided by default\nfor the methods which normally provide it in IO.\n"
  s.email = ["jeremy@bopp.net", "jarred.holman@gmail.com", "grant@lastweekend.com.au", "jpickwell@users.noreply.github.com"]
  s.extra_rdoc_files = ["LICENSE", "LICENSE-rubyspec", "NEWS.md", "README.md"]
  s.files = ["LICENSE", "LICENSE-rubyspec", "NEWS.md", "README.md"]
  s.homepage = "http://github.com/javanthropus/io-like"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "IO::Like Documentation", "--charset", "utf-8", "--line-numbers", "--inline-source"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.1")
  s.rubygems_version = "2.4.5.1"
  s.summary = "A module which provides the functionality of an IO object to any including class which provides a couple of simple methods."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 10.3"])
      s.add_development_dependency(%q<mspec>, ["~> 1.5"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
      s.add_development_dependency(%q<yard-redcarpet-ext>, ["~> 0.0"])
      s.add_development_dependency(%q<github-markup>, ["~> 1.2"])
    else
      s.add_dependency(%q<rake>, ["~> 10.3"])
      s.add_dependency(%q<mspec>, ["~> 1.5"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
      s.add_dependency(%q<yard-redcarpet-ext>, ["~> 0.0"])
      s.add_dependency(%q<github-markup>, ["~> 1.2"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 10.3"])
    s.add_dependency(%q<mspec>, ["~> 1.5"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
    s.add_dependency(%q<yard-redcarpet-ext>, ["~> 0.0"])
    s.add_dependency(%q<github-markup>, ["~> 1.2"])
  end
end
