class UserSetting < ActiveRecord::Base
  belongs_to :user

  attr_accessible :key, :value

end

