require 'simplecov'

SimpleCov.minimum_coverage 100
SimpleCov.start do
  add_filter '.bundle'
  add_filter '/spec/'
  track_files 'lib/**/*.rb'
end

require 'aws_manager'

AwsManager.logger.level = ::Logger::WARN

# avoid warnings
require 'aws-sdk-elasticloadbalancingv2'

require 'pry'
require 'rspec'

require 'spec_helper'
require 'support/aws_hooks'
