require 'yaml'

module ResqueMaster
  class PluginLoader
    def self.load(config_file)
      config = YAML.load_file(config_file)

      config['plugins'].each do |plugin|
        require plugin
      end
    end
  end
end

if File.exist?('config/resque_master.yml')
  ResqueMaster::PluginLoader.load(File.join(Dir.pwd, 'config/resque_master.yml'))
else
  puts '[WARN] No config file found.'
end
