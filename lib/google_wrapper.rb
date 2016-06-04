# require 'googleauth'
# require 'googleauth/web_user_authorizer'
# require 'googleauth/stores/redis_token_store'
# require 'redis'

# class GoogleWrapper

#   CREDENTIALS_FILE = Rails.root.join('tmp', 'google_api_credentials.json')

#   def initialize

#     client_id = Google::Auth::ClientId.from_file(CREDENTIALS_FILE)
#     scope = ENV['GOOGLE_API_SCOPE']
#     token_store = Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)
#     authorizer = Google::Auth::WebUserAuthorizer.new(
#       client_id, scope, token_store, '/oauth2callback')
    
#     credentials_storage = ::Google::APIClient::FileStorage.new(CREDENTIALS_FILE)
#     @client = ::Google::APIClient.new(
#       application_name:    'MyApp',
#       application_version: '1.0.0'
#     )
#     @client.authorization = credentials_storage.authorization || begin
#       installed_app_flow = ::Google::APIClient::InstalledAppFlow.new(
#         client_id:     ENV['GOOGLE_CLIENT_ID'],
#         client_secret: ENV['GOOGLE_CLIENT_SECRET'],
#         scope:         ENV['GOOGLE_API_SCOPE']
#       )
#       installed_app_flow.authorize(credentials_storage)
#     end
#     @drive = @client.discovered_api('drive', 'v2')
#   end

#   def get_drive_files(search_period = 1.week.ago)
#     modified_date = search_period.strftime('%Y-%m-%dT%H:%M:%S%z')
#     result = @client.execute(
#       api_method: @drive.files.list,
#       parameters: {
#         q: %(title contains "proxylist" and modifiedDate > "#{modified_date}")
#       }
#     )
#     file = result.data['items'].first
#     download_url = file['downloadUrl']
#     result = @client.execute(uri: download_url)
#     output_file = Rails.root.join('tmp', file['originalFilename'])
#     IO.binwrite output_file, result.body
#     file['createdDate']
#   end
# end 


# client_id = Google::Auth::ClientId.from_file(CREDENTIALS_FILE)
# scope = ENV['GOOGLE_API_SCOPE']
# token_store = Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)
# authorizer = Google::Auth::WebUserAuthorizer.new(
#   client_id, scope, token_store, '/oauth2callback')


# get('/authorize') do
#   # NOTE: Assumes the user is already authenticated to the app
#   user_id = request.session['user_id']
#   credentials = authorizer.get_credentials(user_id, request)
#   if credentials.nil?
#     redirect authorizer.get_authorization_url(login_hint: user_id, request: request)
#   end
#   # Credentials are valid, can call APIs
#   # ...
# end

# get('/oauth2callback') do
#   target_url = Google::Auth::WebUserAuthorizer.handle_auth_callback_deferred(
#     request)
#   redirect target_url
# end
