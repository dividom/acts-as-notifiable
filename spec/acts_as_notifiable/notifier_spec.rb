# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'rails_helper'

describe 'Acts as notifier' do
  it "should provide a class method 'notifier?' that is false for un-notifier models" do
    expect(UnnotifiableModel).to_not be_notifier
  end

  it "should respond to method 'acts_as_notifier'" do
    expect(UnnotifiableModel).to respond_to(:acts_as_notifier)
  end

  describe 'notifier method generation' do
    before(:each) do
      @notifier = NotifierModel.new
    end

    it 'should respond true to is_notifier?' do
      expect(NotifierModel).to be_notifier
    end

    it "should respond to method 'notify' and 'notify!'" do
      expect(@notifier).to respond_to(:notify)
      expect(@notifier).to respond_to(:notify!)
    end
  end
end
