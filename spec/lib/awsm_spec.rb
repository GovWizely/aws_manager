RSpec.describe Awsm do
  let(:project_dir) { Pathname.new 'spec/fixtures/project' }
  let(:environment) { 'test' }
  let(:region) { 'us-east-1' }

  describe '.manage' do
    let(:config_path) { project_dir.join('create_load_balancer.json').to_s }
    let(:action) { instance_double Awsm::Action }

    it 'executes all actions' do
      expect(Awsm).to receive(:authenticate).with project_dir,
                                                  environment,
                                                  region
      config = instance_double Awsm::Config,
                               actions: [action],
                               root: project_dir,
                               variables_hash: { region: region }

      expect(Awsm).to receive(:load_config).
        with(config_path, environment).
        and_return(config)

      expect(action).to receive(:execute)

      described_class.manage config_path, 'test'
    end
  end

  describe '.authenticate' do
    it 'updates Aws.config with region and credentials' do
      credentials = instance_double Aws::Credentials

      expect(Awsm).to receive(:load_credentials).
        with(project_dir, environment).
        and_return(credentials)

      expect(Aws.config).to receive(:update).with(credentials: credentials,
                                                  region: region)
      described_class.authenticate project_dir,
                                   environment,
                                   region
    end
  end

  describe '.load_credentials' do
    it 'returns an instance of Aws::Credentials' do
      credentials = described_class.load_credentials project_dir, environment
      expect(credentials).to have_attributes(access_key_id: 'my_access_key_id',
                                             secret_access_key: 'my_secret_access_key')
    end
  end
end
