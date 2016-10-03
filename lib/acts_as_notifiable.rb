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
  autoload :Notifying
  autoload :Notifiable
  autoload :Notified
  autoload :Notifier
  autoload :VERSION
end

ActiveSupport.on_load(:active_record) do
  extend ActsAsNotifiable::Notifiable
  include ActsAsNotifiable::Notified
  include ActsAsNotifiable::Notifier
end
