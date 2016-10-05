# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'rails_helper'

describe ActsAsNotifiable::Notifying, type: :model do
  before(:each) do
    @valid_notified = NotifiedModel.new(name: 'Bryan')
    @invalid_notified = UnnotifiableModel.new()
    @notification = ActsAsNotifiable::Notification.new(body: 'Emma has sent a message.')
    @notifying = ActsAsNotifiable::Notifying.new()
  end

  describe 'should belong to notification and notified' do
    it { is_expected.to belong_to(:notification) }
    it { is_expected.to belong_to(:notified) }
  end

  describe 'should have validations' do
    it { is_expected.to validate_presence_of(:notification_id) }
    it { is_expected.to validate_uniqueness_of(:notification_id).scoped_to([:notified_id, :notified_type]) }

    it 'should validate presence of notification' do
      @notifying.notified = @valid_notified

      expect(@notifying).to be_invalid
      expect(@notifying.errors[:notification_id]).to include("can't be blank")
    end

    it 'should validate that notified is a a ActsAsNotifiable::Notified' do
      @notifying.notified = @invalid_notified
      @notifying.notification = @notification

      expect(@notifying).to be_invalid
      expect(@notifying.errors[:notified]).to include('is not a ::ActsAsNotifiable::Notified object')
    end
  end
end
