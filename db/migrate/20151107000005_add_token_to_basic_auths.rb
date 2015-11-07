class AddTokenToBasicAuths < ActiveRecord::Migration
  def change
    add_column :basic_auths, :token, :string
    add_column :basic_auths, :verified, :boolean
    add_column :basic_auths, :password_reset, :boolean
  end
end
