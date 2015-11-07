class CreateBasicAuths < ActiveRecord::Migration
  def up
    create_table :basic_auths do |t|
      t.column :email, :string, null: false
      t.column :password_digest, :string
      t.column :username, :string
      t.column :identity_id, :integer
    end

    change_table :basic_auths do |t|
      t.index :email, { unique: true }
      t.index :username
      t.index :identity_id
    end
  end

  def down
    drop_table :basic_auths
  end
end
