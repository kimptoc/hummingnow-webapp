Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
#  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :twitter, Figaro.env.twitter_consumer_key, Figaro.env.twitter_consumer_secret
end

