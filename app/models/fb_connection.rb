class FbConnection
  CACHE_EXPIRATION = 4.hours.to_s
  
  def self.graph
    return @graph if @graph.present?
    oauth = Koala::Facebook::OAuth.new
    token = oauth.get_app_access_token
    @graph = Koala::Facebook::API.new(token)
  end
  
  def self.get_connections(object, edges)
    self.cached_request("#{object}-#{edges}") do 
      self.graph.get_connections(object, edges)  
    end
  end
  
  def self.get_object(object)
    self.cached_request("#{object}-object") do 
      self.graph.get_object(object)  
    end
  end
  
  def self.cached_request(cache_key, &block)
    begin
      Rails.cache.fetch(cache_key, :expires_in => CACHE_EXPIRATION) do
        block.call
      end
    rescue Koala::Facebook::APIError => e
      Rails.logger.error e
      return ""
    end
  end
  
end