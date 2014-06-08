require 'rails_helper'

RSpec.describe FbConnection, :type => :model do  
  before(:all) do
    Timecop.freeze(Time.now)
    Rails.cache.clear
  end
  
  after(:all) do
    Timecop.return
  end
  
  describe "caching behaviour" do
    
    it "should set something in cache when using cached_request" do
      expect(Rails.cache.read("cache_key")).to be_nil
      FbConnection.cached_request("cache_key") do 
        "some results"
      end
      expect(Rails.cache.read("cache_key")).to eq("some results")
    end

    it "should get result from cache if it is there" do
      FbConnection.cached_request("cache_key") do 
        "some results 2"
      end
      expect(Rails.cache.read("cache_key")).to eq("some results")
    end

    it "should refresh the result if time is above CACHE_EXPIRATION" do
      Timecop.travel(Time.now + FbConnection::CACHE_EXPIRATION)
      
      expect(Rails.cache.read("cache_key")).to be_nil
      FbConnection.cached_request("cache_key") do 
        "some results 2"
      end
      expect(Rails.cache.read("cache_key")).to eq("some results 2")
    end

  end
end
