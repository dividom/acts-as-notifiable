# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'rails_helper'

describe ActsAsNotifiable::Notification, type: :model do

  describe 'should belong to notifiable and notifier' do
    it { is_expected.to belong_to(:notifiable) }
    it { is_expected.to belong_to(:notifier) }
  end

  describe 'should have many notifyings and notifieds' do
    it { is_expected.to have_many(:notifyings) }
    it { is_expected.to have_many(:notifieds) }
  end

  describe 'should have validations' do

    before(:each) do
      @valid_notifier = NotifierModel.new(name: 'Hanz')
      @invalid_notifier = UnnotifiableModel.new()
      @valid_notifiable = NotifiableModel.new()
      @invalid_notifiable = UnnotifiableModel.new()

      @notification = ActsAsNotifiable::Notification.new(body: 'Frieda has sent a message.')
    end

    ##
    # Common validations
    #
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(255) }

    ##
    # Custom validations
    #
    it 'should validate that notifiable is a ActsAsNotifiable::Notifiable' do
      @notification.notifiable = @invalid_notifiable
      @notification.notifier = @valid_notifier

      expect(@notification).to be_invalid
      expect(@notification.errors[:notifiable]).to include("is not a ::ActsAsNotifiable::Notifiable object")
    end

    it 'should validate that notifier is a ActsAsNotifiable::Notifier' do
      @notification.notifiable = @valid_notifiable
      @notification.notifier = @invalid_notifier

      expect(@notification).to be_invalid
      expect(@notification.errors[:notifier]).to include('is not a ::ActsAsNotifiable::Notifier object')
    end
  end
end
