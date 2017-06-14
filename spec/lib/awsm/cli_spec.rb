RSpec.describe Awsm::CLI do
  describe '.start' do
    before do
      $thor_runner = false
      $0 = 'awsm'
      ARGV.clear
    end
    context 'when parameters are not present' do
      it 'prints usage' do
        expect { described_class.start(ARGV) }.to output(/awsm help/).to_stdout
      end
    end

    context 'when ACTIONS_FILE_PATH is present' do
      it 'executes Awsm.manage' do
        absolute_path = 'spec/fixtures/project/create_load_balancer.json'
        parameters = [
          'manage',
          absolute_path,
          '-e',
          'test'
        ]
        expect(Awsm).to receive(:manage).with(absolute_path, 'test')
        described_class.start parameters
      end
    end
  end
end
