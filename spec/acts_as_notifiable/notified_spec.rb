# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'rails_helper'

describe 'Acts as notified' do
  it "should provide a class method 'notified?' that is false for un-notified models" do
    expect(UnnotifiableModel).to_not be_notified
  end

  it "should respond to method 'acts_as_notified'" do
    expect(UnnotifiableModel).to respond_to(:acts_as_notified)
  end

  describe 'Notified method generation' do
    before(:each) do
      @notified = NotifiedModel.new
    end

    it 'should respond true to is_notified?' do
      expect(NotifiedModel).to be_notified
    end

    it "should respond to method 'notify' and 'notify!'" do
      expect(@notified).to respond_to(:notify)
      expect(@notified).to respond_to(:notify!)
    end
  end
end
