require 'yaml'

module ResqueMaster
  class PluginLoader
    def self.load
      return unless ResqueMaster.config && ResqueMaster.config['plugins']

      ResqueMaster.config['plugins'].each do |plugin|
        require plugin
      end
    end
  end
end
