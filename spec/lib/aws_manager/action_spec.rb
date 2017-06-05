RSpec.describe AwsManager::Action do
  let(:config) do
    AwsManager.load_config Pathname.new('spec/fixtures/project/create_load_balancer.json').to_s
  end

  let(:action) { config.actions.first }

  describe '#parameters' do
    it 'loads variables' do
      expected_parameters = {
        name: 'my-load-balancer',
        subnets: %w(subnet-01 subnet-02)
      }
      expect(action.parameters).to eq(expected_parameters)
    end
  end

  describe '#execute' do
    context 'when map_response_to_variable is present' do
      let!(:client) { Aws::ElasticLoadBalancingV2::Client.new }
      let(:response) do
        client.stub_data :create_load_balancer,
                         load_balancers: [
                           { load_balancer_arn: 'my-load-balancer-arn' }
                         ]
      end

      before do
        expect(Aws::ElasticLoadBalancingV2::Client).to receive(:new).and_return(client)
      end

      it 'maps response to variable' do
        expect(client).to receive(:send).with(:create_load_balancer,
                                              name: 'my-load-balancer',
                                              subnets: %w(subnet-01 subnet-02)).and_return(response)
        action.execute
        expect(config.variables_hash[:load_balancer_arn]).to eq('my-load-balancer-arn')
      end
    end
  end
end
