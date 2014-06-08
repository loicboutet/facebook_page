class Page < ActiveRecord::Base
  attr_accessible :facebook_id
  validates_presence_of    :facebook_id
  validates_uniqueness_of  :facebook_id
  
  def facebook_attributes
    facebook.get_object(self.facebook_id)
  end

  def albums
    facebook.get_connections(self.facebook_id, "albums")    
  end

  def events
    facebook.get_connections(self.facebook_id, "events")    
  end

  def feed
    facebook.get_connections(self.facebook_id, "feed")  
  end
  
  #TODO add other method for the rest of the edges

  def facebook
    FbConnection
  end
end
