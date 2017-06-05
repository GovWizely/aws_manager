RSpec.configure do |config|
  config.before(:suite) do
    AwsManager.authenticate AwsManager.root.join('spec/fixtures/project'), 'us-east-1'
  end
end
