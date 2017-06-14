RSpec.describe Awsm::OptionLoader do
  describe '#load' do
    let(:root) { Pathname.new 'spec/fixtures/project' }

    let(:variables_hash) do
      {
        certificate_file_name: 'input.txt',
        stack: 'my_stack',
        vpc_id: 'my_vpc_id'
      }
    end

    context 'when _file is present' do
      it 'returns the content of the file' do
        option_loader = described_class.new root, variables_hash
        parameters = {
          nested: {
            certificate: {
              _file: {
                _variable: 'certificate_file_name'
              }
            }
          }
        }

        expected_parameters = {
          nested: {
            certificate: "foo\nbar\n"
          }
        }

        expect(option_loader.load(parameters)).to eq(expected_parameters)
      end
    end

    context 'when _variable hash is a Hash value' do
      it 'substitutes _variable hash with the value' do
        option_loader = described_class.new root, variables_hash
        parameters = {
          nested: {
            vpc_id_param: {
              _variable: :vpc_id
            },
            another_param: 'foo'
          }
        }

        expected_parameters = {
          nested: {
            vpc_id_param: 'my_vpc_id',
            another_param: 'foo'
          }
        }

        expect(option_loader.load(parameters)).to eq(expected_parameters)
      end
    end

    context 'when _variable hash is an item in an Array' do
      it 'substitutes _variable hash with the value' do
        option_loader = described_class.new root, variables_hash
        parameters = {
          nested: {
            tags: [
              { _variable: :stack },
              { _variable: :vpc_id }
            ]
          }
        }

        expected_parameters = {
          nested: {
            tags: %w(my_stack my_vpc_id)
          }
        }

        expect(option_loader.load(parameters)).to eq(expected_parameters)
      end
    end

    context 'when _template hash is a value' do
      before do
        expect(DateTime).to receive(:now).and_return(DateTime.strptime('2017-05-17T12:16:46-04:00'))
      end
      it 'substitutes _variable hash with the value' do
        option_loader = described_class.new root, variables_hash
        parameters = {
          nested: {
            description: {
              _template: 'created at %{now}'
            },
            foo: 'bar'
          }
        }

        expected_parameters = {
          nested: {
            description: 'created at 2017-05-17T12:16:46-04:00',
            foo: 'bar'
          }
        }

        expect(option_loader.load(parameters)).to eq(expected_parameters)
      end
    end
  end
end
