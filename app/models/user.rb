class User < ActiveRecord::Base
  has_many :authentications
  has_many :user_settings

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def apply_omniauth(omniauth)
    case omniauth['provider']
    when 'twitter'
      self.apply_twitter(omniauth)
    end
    authentications.build(hash_from_omniauth(omniauth))
  end

  #def facebook
  #  @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  #end

  def twitter(nickname)
    @twitter_user ||= {}
    unless @twitter_user[nickname]
      provider = self.authentications.where(:nickname => nickname).find_by_provider('twitter')
      @twitter_user[nickname] = Twitter::REST::Client.new do |config|
        config.access_token         = provider.token
        config.access_token_secret  = provider.secret
        config.consumer_key         = Figaro.env.twitter_consumer_key
        config.consumer_secret      = Figaro.env.twitter_consumer_secret
      end
    end
    @twitter_user[nickname]
  end

  @@tweetstream = TweetStream.configure do |config|
    config.consumer_key       = Figaro.env.twitter_consumer_key
    config.consumer_secret    = Figaro.env.twitter_consumer_secret
    config.oauth_token        = Figaro.env.twitter_oauth_token
    config.oauth_token_secret = Figaro.env.twitter_oauth_token_secret
    config.auth_method        = :oauth
  end

  @@twitter_noauth = Twitter::REST::Client.new do |config|
    config.access_token = Figaro.env.twitter_oauth_token
    config.access_token_secret = Figaro.env.twitter_oauth_token_secret
    config.consumer_key = Figaro.env.twitter_consumer_key
    config.consumer_secret = Figaro.env.twitter_consumer_secret
  end

  def self.twitter_noauth
    @@twitter_noauth
  end

  def lists(nickname)
    Rails.logger.debug "user.lists"
    lists_array = []
    twitter(nickname).lists.each do |list|
      list_hash = {}
      list_hash['name'] = list.name
      list_hash['full_name'] = list.full_name
      list_hash['id_str'] = list.id.to_s
      lists_array << list_hash
    end
    return lists_array
  end

  protected

  def apply_twitter(omniauth)
    self.email = omniauth['info']['nickname'] if self.email.nil?
  end

  def hash_from_omniauth(omniauth)
    {
      :provider => omniauth['provider'],
      :uid => omniauth['uid'],
      :token => (omniauth['credentials']['token'] rescue nil),
      :secret => (omniauth['credentials']['secret'] rescue nil),
      :nickname => (omniauth['info']['nickname'] rescue nil),
      :name => (omniauth['info']['name'] rescue nil),
      :avatar_url => (omniauth['info']['image'] rescue nil)
    }
  end


end
