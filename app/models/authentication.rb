class Authentication < ActiveRecord::Base
  belongs_to :user

  attr_accessible :provider, :uid, :token, :secret, :nickname, :name, :avatar_url

end
