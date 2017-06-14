require 'awsm/action'

module Awsm
  class Config
    attr_reader :actions, :root, :variables_hash

    def initialize(root, environment, variables_yaml_str, actions_json_str)
      @root = root
      @variables_hash = HashWithIndifferentAccess.new(YAML.load(variables_yaml_str)[environment])
      @actions = JSON.parse actions_json_str, symbolize_names: true
    end

    def actions
      Enumerator.new do |y|
        @actions.each do |action_hash|
          action_hash.each do |(name, options)|
            y << Awsm::Action.new(config: self,
                                  name: name,
                                  options: options)
          end
        end
      end
    end
  end
end
