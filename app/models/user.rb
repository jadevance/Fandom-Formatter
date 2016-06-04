class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true
  validate  :provider_must_be_google

  def provider_must_be_google
    if provider != "google_oauth2"
      errors.add(:provider, "provider must be google_oauth2")
    end
  end


  def self.find_or_create_from_omniauth(auth_hash)
    user = self.find_by(uid: auth_hash['info']['uid'], provider: auth_hash['provider'])
    if !user.nil?
      return user
    else
        user = User.new 
        user.provider = auth_hash.provider
        user.uid = auth_hash.uid
        user.name = auth_hash.info.name
        user.image = auth_hash.info.image 
        user.oauth_token = auth_hash.credentials.token
        user.oauth_expires_at = Time.at(auth_hash.credentials.expires_at)
        user.save!
      if user.save
        return user
      else
        return nil
      end
    end
  end
end
