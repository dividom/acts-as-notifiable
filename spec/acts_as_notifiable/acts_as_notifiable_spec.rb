# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'rails_helper'

describe 'Acts as notifiable' do
  it "should provide a class method 'notifiable?' that is false for un-notifiable models" do
    expect(UnnotifiableModel).to_not be_notifiable
  end

  it "should respond to method 'acts_as_notifiable'" do
    expect(UnnotifiableModel).to respond_to(:acts_as_notifiable)
  end

  describe 'Notifiable method generation' do
    before(:each) do
      @notifiable = NotifiableModel.new
    end

    it 'should respond true to notifiable?' do
      expect(NotifiableModel).to be_notifiable
    end

    it "should respond to method 'notify_about' and 'notify_about!'" do
      expect(@notifiable).to respond_to(:notify_about)
      expect(@notifiable).to respond_to(:notify_about!)
    end
  end

  describe NotifiableModel, type: :model do
    it { is_expected.to have_many(:related_notifications) }
  end
end
