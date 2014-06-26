#
# Verbose Log - logs to either Rail's logger and STDOut
# depending on environment
#
# @param message [String] log message
#
def vlog(message)
  puts message if Rails.env.development?
  Rails.logger.info message
end

#
# Notifies airbrake and logs/stdouts the error message
#
# @param message [String] error message
# @param params [Hash] error message parameters
# @param backtrace [Thread::Backtrace] backtrace of the error
#
def elog(message, params={}, backtrace=nil)
  vlog message
  vlog backtrace.to_yaml if backtrace.present?
  Airbrake.notify(
    error_class:    message,
    error_message:  message,
    parameters:     params.filter,
    backtrace:      backtrace
  ) unless Rails.env.development? || Rails.env.test?
end

#
# Given a database url, returns a database connection configuration hash
#
# @param config [String] database url
#
# @return [Hash] database connection configuration
#
def connection_config_for(database_url)
  puts ENV[database_url]
  db = URI.parse(ENV[database_url])
  {
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  }
end