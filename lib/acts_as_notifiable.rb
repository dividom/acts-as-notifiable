require 'active_record'
require 'active_record/version'
require 'active_support/core_ext/module'

module ActsAsNotifiable
  extend ActiveSupport::Autoload

  autoload :Notification
end
