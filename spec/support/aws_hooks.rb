RSpec.configure do |config|
  config.before(:suite) do
    Awsm.authenticate Awsm.root.join('spec/fixtures/project'), 'test', 'us-east-1'
  end
end
