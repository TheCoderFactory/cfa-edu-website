require 'spec_helper'

describe FeedsController do

  describe "GET 'blog'" do
    it "returns http success" do
      get 'blog'
      response.should be_success
    end
  end

  describe "GET 'course'" do
    it "returns http success" do
      get 'course'
      response.should be_success
    end
  end

end
