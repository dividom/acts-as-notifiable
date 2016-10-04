# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'Acts as notifiable' do
  it "should provide a class method 'notifiable?' that is false for un-notifiable models" do
    expect(UnnotifiableModel).to_not be_notifiable
  end
end
