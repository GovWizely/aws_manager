require 'thor'

module Awsm
  class CLI < Thor
    desc 'manage ACTIONS_FILE_PATH', 'manages AWS by executing actions in the specified file'
    option :environment, aliases: '-e', default: 'development', desc: 'Specifies the environment to run'
    def manage(actions_file_path)
      Awsm.manage actions_file_path, options[:environment]
    end
  end
end
