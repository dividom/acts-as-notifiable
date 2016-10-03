require 'active_record'
require 'active_record/version'
require 'active_support/core_ext/module'

begin
  require 'rails/engine'
  require 'acts_as_notifiable/engine'
  rescue LoadError
    
end

module ActsAsNotifiable
  extend ActiveSupport::Autoload

  autoload :Notification
end
