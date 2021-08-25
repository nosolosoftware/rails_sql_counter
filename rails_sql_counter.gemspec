require_relative 'lib/rails_sql_counter/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails_sql_counter'
  spec.version       = RailsSqlCounter::VERSION
  spec.authors       = ['rjurado']
  spec.email         = ['rjurado@nosolosoftware.es']

  spec.summary       = 'Keep under control how many sql queries are launched in your App'
  spec.description   = 'Allows to control how many queries are launched between two points'
  spec.homepage      = 'https://github.com/nosolosoftware/rails_sql_counter'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport'
end
