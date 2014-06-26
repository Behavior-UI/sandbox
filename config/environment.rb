# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load pow environment variables into development and test environments
if File.exist?(".powenv")
  IO.foreach('.powenv') do |line|
    next if !line.include?('export') || line.blank?
    key, value = line.gsub('export','').split('=',2)
    ENV[key.strip] = value.delete('"\'').strip
  end
end if Rails.env.development? || Rails.env.test?

# Auto-require all files in lib/extensions
Dir["#{Rails.root}/lib/extensions/**/*.rb"].each do |extension|
  require extension
end

# declare worker termination error class
class ShutdownSignal < StandardError; end

class Hash
  def accessible
    return ActiveSupport::HashWithIndifferentAccess.new(self)
  end

  def filter
    return ActionDispatch::Http::ParameterFilter.new(Rails.application.config.filter_parameters).filter(self)
  end
end

# extend string class
class String
  def underscores_to_spaces
    self.gsub(/_/, ' ')
  end
end


# Initialize the Rails application.
Sandbox::Application.initialize!
