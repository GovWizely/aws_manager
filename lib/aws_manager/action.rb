require 'active_support/inflector/inflections'

require 'aws_manager/option_loader'

module AwsManager
  class Action
    attr_reader :config, :name, :target

    def initialize(config:, name:, options:, target: nil)
      @config = config
      @name = name
      @options = options
      @option_loader = AwsManager::OptionLoader.new @config.root, @config.variables_hash
      @target = target || detect_target
    end

    def parameters
      @option_loader.load(@options[:parameters]).deep_symbolize_keys
    end

    def execute
      AwsManager.logger.info "#{target.class.name}: executing #{name} with:\n#{parameters.to_yaml}"
      response = target.send name, parameters
      AwsManager.logger.info "Response:\n#{response.inspect}"

      if (map_response_options = @options[:map_response_to_variable])
        @config.variables_hash[map_response_options[:key]] = send_method_chain_to_response response, map_response_options[:method]
      end
    end

    private

    def detect_target
      if @options[:target_instance]
        target_class = ActiveSupport::Inflector.constantize @options[:target_instance][:target_class_name]
        init_params = @options[:target_instance][:initialize_parameters] || {}
        target_class.new @option_loader.load(init_params)
      end
    end

    def send_method_chain_to_response(response, method_chain_str)
      return response unless method_chain_str

      method_chain_str.split('.').inject(response) do |target, method|
        target.send method.to_sym
      end
    end
  end
end
