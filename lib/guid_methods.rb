module GuidMethods

  def self.new_guid
    Digest::MD5.hexdigest(Time.now.to_s + rand(1000000000000000).to_s)
  end
end