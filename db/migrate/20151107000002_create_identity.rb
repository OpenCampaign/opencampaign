class CreateIdentity < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user
      t.string :provider
      t.string :uid
      t.string :username
      t.string :affiliation
      t.string :name
      t.string :email
      t.string :phone
      t.string :phone_secondary

      t.timestamps
    end

    add_index :identities, :user_id
    add_index :identities, [:provider, :uid]
    add_index :identities, [:user_id, :updated_at]
  end
end
