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

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.include ActsAsNotifiable::Notifiable
    ActiveRecord::Base.include ActsAsNotifiable::Notified
    ActiveRecord::Base.include ActsAsNotifiable::Notifier
  end
end
