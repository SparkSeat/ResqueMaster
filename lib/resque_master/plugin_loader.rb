require 'yaml'

module ResqueMaster
  class PluginLoader
    def self.load
      ResqueMaster.config['plugins'].each do |plugin|
        require plugin
      end
    end
  end
end
