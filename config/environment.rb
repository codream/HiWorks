# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
HiWorks::Application.initialize!
ENV['RAILS_ENV'] ||= 'production'
#ENV['TZ'] = 'Asia/Taipei'
