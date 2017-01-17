class Applog < Logger
  def initialize(path)
    File.delete(path) if File.exist?(path)
    super(path)
  end

  def startup_log(driver_type)
    $logger.info "Configs requested #{driver_type} to be started..."
  end

  def initializing_object(object_name)
    $logger.info "Initializing #{object_name} object..."
  end
end
