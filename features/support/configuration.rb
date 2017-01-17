require 'json'
require 'yaml'

class Configuration

  attr_accessor :config_path, :logs, :browser, :browser_version, :os, :os_version, :name, :prefix, :env,
                :driver_type

  def initialize
    $logger.initializing_object('Configuration')
    @config_path = 'config/configuration.yml'
    @conf = get_configs(@config_path)
  end

  def get_param(param, default=nil)
    custom_if_empty(param, default)
  end

  def get_configs(full_name)
    $logger.info "Parsing configuration file as '#{full_name}'..."
    if File.exist? full_name
      return YAML.load_file full_name
    else
      $logger.fatal "No config file named '#{full_name}'"
    end
  end

  def set_configs(configs)
    $logger.info "Parsing configurations of environment as '#{configs}'..."
    data = YAML.load_file @config_path

    begin
      jconf = JSON.parse configs

      new_hash = {}
      data.each do |key, value|
        jconf_value = jconf[key]

        if jconf_value.nil?
          new_hash.merge!({key => value})
        else
          if jconf_value.is_a?(Hash) and value.is_a?(Hash)
            temp_value = value.merge(jconf_value)
          elsif jconf_value.is_a?(Array) and value.is_a?(Array)
            temp_value = jconf_value + value
          else
            temp_value = jconf_value
          end
          new_hash.merge!({key => temp_value})
        end
      end

      File.open(@config_path, 'w') { |f| YAML.dump(new_hash, f) }
    rescue Exception => e
      $logger.error 'Something wrong with TEST_CONF env variable or it does not exist...'
      puts e
    end
  end

  def custom_if_empty(param, custom)
    param_value = @conf[param]
    if param_value.nil? || param_value.empty?
      $logger.warn "No '#{param}' specified in config file ,using '#{custom}' default..." unless $logger.nil?
      custom
    else
      param_value
    end
  end

end

if __FILE__==$0
  hash = ENV['TEST_CONF']
  Configuration.new.set_configs(hash)
end