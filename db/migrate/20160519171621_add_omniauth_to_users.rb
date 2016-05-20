class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rails, :string
    add_column :users, :g, :string
    add_column :users, :migration, :string
    add_column :users, :AddOmniauthToUsers, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :picture, :string
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end
