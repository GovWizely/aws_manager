require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: :spec

desc 'manage AWS'
task :manage, :config_file_path do |_t, args|
  require_relative 'lib/awsm'
  Awsm.manage args[:config_file_path]
end
