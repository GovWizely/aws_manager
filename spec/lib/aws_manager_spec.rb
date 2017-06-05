RSpec.describe AwsManager do
  let(:project_dir) { Pathname.new 'spec/fixtures/project' }
  let!(:credentials) { Aws::Credentials.new 'my_access_key_id', 'my_secret_access_key' }

  describe '.authenticate' do
    before do
      expect(Aws::Credentials).to receive(:new).
        with('my_access_key_id',
             'my_secret_access_key').
        and_return(credentials)
    end

    it 'updates Aws.config with region and credentials' do
      expect(Aws.config).to receive(:update).with(credentials: credentials,
                                                  region: 'us-west-1')
      described_class.authenticate project_dir, 'us-west-1'
    end
  end

  describe '.manage' do
    let(:config_path) { project_dir.join('create_load_balancer.json').to_s }
    let!(:config) { AwsManager.load_config config_path }
    let(:action) { instance_double(AwsManager::Action) }

    before do
      expect(AwsManager::Config).to receive(:new).and_return(config)
    end

    it 'executes all actions' do
      expect(config).to receive(:actions).and_return([action])
      expect(action).to receive(:execute)
      config = described_class.manage project_dir.join('create_load_balancer.json')
    end
  end
end
