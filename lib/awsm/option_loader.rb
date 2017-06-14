module Awsm
  class OptionLoader
    def initialize(root, variables_hash)
      @root = root
      @variables_hash = variables_hash
    end

    def load(options)
      case options
      when Array
        load_array options
      when Hash
        load_hash options
      else
        options
      end
    end

    private

    def load_array(array)
      array.map { |item| load item }
    end

    def load_hash(hash)
      if hash[:_file]
        @root.join(load_hash(hash[:_file])).read
      elsif hash[:_variable]
        @variables_hash[hash[:_variable].to_sym]
      elsif hash[:_template]
        hash[:_template] % { now: DateTime.now.to_s }
      else
        hash.each_with_object({}) do |(key, value), result_hash|
          result_hash[key] = load value
        end
      end
    end
  end
end
