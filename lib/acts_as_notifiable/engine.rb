require 'rails/engine'
module ActsAsNotifiable
  class Engine < Rails::Engine
    isolate_namespace ActsAsNotifiable
  end
end
