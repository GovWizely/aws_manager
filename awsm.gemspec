Gem::Specification.new do |s|
  s.name        = 'awsm'
  s.version     = '0.1.0'
  s.date        = '2017-06-14'
  s.summary     = "Awsm"
  s.description = "Awsm"
  s.authors     = ['Kerits & Letus']
  s.homepage    = 'https://github.com/GovWizely/awsm'

  s.add_dependency 'activesupport', '~> 5.1.1'
  s.add_dependency 'aws-sdk', '~> 3.0.0.rc8'
  s.add_dependency 'thor', '~> 0.19.4'

  s.add_development_dependency 'pry', '0.10.4'

  s.files       = %w(README.md awsm.gemspec)
  s.files       += Dir['lib/**/*.rb']

  s.bindir        = 'exe'
  s.executables   = %w(awsm)
  s.require_paths = %w(lib)
end
