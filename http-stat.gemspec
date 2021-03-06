
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "http-stat/version"

Gem::Specification.new do |spec|
  spec.name          = "http-stat"
  spec.version       = HttpStat::VERSION
  spec.authors       = ["gazayas"]
  spec.email         = ["g-zayas@hotmail.com"]

  spec.summary       = %q{A command line tool for looking up the details of http (HyperText Transfer Protocol) statuses}
  spec.homepage      = "http://www.github.com/gazayas/http-stat"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["http-stat"] # spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "colorize"
end
