require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @known = { "provider" => "google_oauth2", "info" =>  { "id" => "known_user", "display_name" => "known user" , "images" => ["url" => "http://i.imgur.com/2D35e.jpg"]}}
    @unknown = { "provider" => "google_oauth2", "info" => { "id" => "unknown_user", "display_name" => "unknown user" , "images" => ["url" => "http://i.imgur.com/2D35e.jpg"]} }
    @unknown_with_uid = OmniAuth.config.mock_auth[:spotify_uid]
  end
  
  test "creates new user with oauth google hash of unknown user" do
    assert_difference 'User.count', 1 do
      @user = User.find_or_create_from_omniauth @unknown
    end
  end

  test "finds an existing user given an oauth google hash" do
    assert_equal users(:known_user), User.find_or_create_from_omniauth(@known)
  end

  test "uses oauth data to set data for new users" do
   user = User.find_or_create_from_omniauth @unknown

   assert_equal @unknown['provider'], user.provider
   assert_equal @unknown['info']['id'], user.uid
   assert_equal @unknown['info']['display_name'], user.display_name
  end

  test "validation: provider must be google" do
    user = User.new
    user.provider = "Googly Eyes"
    assert_not user.valid?
    assert user.errors.keys.include?(:provider), "provider is not in the errors hash"
  end

  test "validation: provider must be present" do
    user = User.new
    assert_not user.valid?
    assert user.errors.keys.include?(:provider), "provider is not the errors hash"
  end

  test "validation: uid must be present" do
    user = User.new
    assert_not user.valid?
    assert user.errors.keys.include?(:uid), "uid is not in the errors hash"
  end
end
