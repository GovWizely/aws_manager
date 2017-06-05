require 'aws_manager/action'

module AwsManager
  class Config
    attr_reader :actions, :root, :variables_hash

    def initialize(root, variables_yaml_str, actions_json_str)
      @root = root
      @variables_hash = HashWithIndifferentAccess.new YAML.load(variables_yaml_str)
      @actions = JSON.parse actions_json_str, symbolize_names: true
    end

    def actions
      Enumerator.new do |y|
        @actions.each do |action_hash|
          action_hash.each do |(name, options)|
            y << AwsManager::Action.new(config: self,
                                        name: name,
                                        options: options)
          end
        end
      end
    end
  end
end
