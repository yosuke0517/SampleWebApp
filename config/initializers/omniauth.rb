Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.twitter[:key], Rails.application.credentials.twitter[:secret]
#   provider :facebook, Rails.application.secrets[:facebook][:key], Rails.application.secrets[:facebook][:secret]
#   provider :google_oauth2, Rails.application.secrets[:google_oauth2][:key], Rails.application.secrets[:google_oauth2][:secret]
#   Rails.application.credentials.twitter[:api_key]
end
