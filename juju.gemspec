# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "juju"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Elena Burachevskaya"]
  s.date = "2013-07-17"
  s.description = "Get the jobs feed using JuJu API."
  s.email = "elena.burachevskaya@startdatelabs.com"
  s.extra_rdoc_files = ["README.rdoc", "lib/juju.rb"]
  s.files = ["README.rdoc", "Rakefile", "lib/juju.rb", "Manifest", "juju.gemspec"]
  s.homepage = "https://github.com/startdatelabs/juju"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Juju", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "juju"
  s.rubygems_version = "1.8.25"
  s.summary = "Get the jobs feed using JuJu API."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
