# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{json-rpc-objects}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martin Kozák"]
  s.date = %q{2011-01-16}
  s.email = %q{martinkozak@martinkozak.net}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "json-rpc-objects.gemspec",
    "lib/json-rpc-objects/error.rb",
    "lib/json-rpc-objects/generic.rb",
    "lib/json-rpc-objects/request.rb",
    "lib/json-rpc-objects/response.rb",
    "lib/json-rpc-objects/v10/error.rb",
    "lib/json-rpc-objects/v10/fakes/error.rb",
    "lib/json-rpc-objects/v10/request.rb",
    "lib/json-rpc-objects/v10/response.rb",
    "lib/json-rpc-objects/v10/tests/test.rb",
    "lib/json-rpc-objects/v11/alt/error.rb",
    "lib/json-rpc-objects/v11/alt/fakes/request.rb",
    "lib/json-rpc-objects/v11/alt/fakes/response.rb",
    "lib/json-rpc-objects/v11/alt/procedure-call.rb",
    "lib/json-rpc-objects/v11/alt/procedure-parameter-description.rb",
    "lib/json-rpc-objects/v11/alt/procedure-return.rb",
    "lib/json-rpc-objects/v11/alt/request.rb",
    "lib/json-rpc-objects/v11/alt/response.rb",
    "lib/json-rpc-objects/v11/alt/service-description.rb",
    "lib/json-rpc-objects/v11/alt/service-procedure-description.rb",
    "lib/json-rpc-objects/v11/alt/tests/test.rb",
    "lib/json-rpc-objects/v11/generic-types.rb",
    "lib/json-rpc-objects/v11/wd/error.rb",
    "lib/json-rpc-objects/v11/wd/extensions.rb",
    "lib/json-rpc-objects/v11/wd/fakes/request.rb",
    "lib/json-rpc-objects/v11/wd/fakes/response.rb",
    "lib/json-rpc-objects/v11/wd/procedure-call.rb",
    "lib/json-rpc-objects/v11/wd/procedure-parameter-description.rb",
    "lib/json-rpc-objects/v11/wd/procedure-return.rb",
    "lib/json-rpc-objects/v11/wd/request.rb",
    "lib/json-rpc-objects/v11/wd/response.rb",
    "lib/json-rpc-objects/v11/wd/service-description.rb",
    "lib/json-rpc-objects/v11/wd/service-procedure-description.rb",
    "lib/json-rpc-objects/v11/wd/tests/test.rb",
    "lib/json-rpc-objects/v20/error.rb",
    "lib/json-rpc-objects/v20/request.rb",
    "lib/json-rpc-objects/v20/response.rb",
    "lib/json-rpc-objects/v20/tests/test.rb",
    "lib/json-rpc-objects/version.rb"
  ]
  s.homepage = %q{http://github.com/martinkozak/json-rpc-objects}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Implementation of JSON-RPC objects with respect to specifications compliance and API backward compatibility. Implements all versions of the protocol and support for ability to communicate by the same protocol version which other side uses by a transparent way.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multitype-introspection>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<hash-utils>, [">= 0.3.0"])
      s.add_runtime_dependency(%q<types>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<version>, [">= 0.9.2"])
      s.add_runtime_dependency(%q<addressable>, [">= 2.2.2"])
      s.add_runtime_dependency(%q<yajl-ruby>, [">= 0.7.8"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
    else
      s.add_dependency(%q<multitype-introspection>, [">= 0.1.0"])
      s.add_dependency(%q<hash-utils>, [">= 0.3.0"])
      s.add_dependency(%q<types>, [">= 0.1.0"])
      s.add_dependency(%q<version>, [">= 0.9.2"])
      s.add_dependency(%q<addressable>, [">= 2.2.2"])
      s.add_dependency(%q<yajl-ruby>, [">= 0.7.8"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    end
  else
    s.add_dependency(%q<multitype-introspection>, [">= 0.1.0"])
    s.add_dependency(%q<hash-utils>, [">= 0.3.0"])
    s.add_dependency(%q<types>, [">= 0.1.0"])
    s.add_dependency(%q<version>, [">= 0.9.2"])
    s.add_dependency(%q<addressable>, [">= 2.2.2"])
    s.add_dependency(%q<yajl-ruby>, [">= 0.7.8"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
  end
end
