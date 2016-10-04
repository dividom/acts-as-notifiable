Rails.application.routes.draw do

  mount ActsAsNotifiable::Engine => "/acts_as_notifiable"
end
