class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.string :token
      t.string :secret

      t.string :nickname
      t.string :name
      t.string :avatar_url

      t.timestamps
    end
  end
end
