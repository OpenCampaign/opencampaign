class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.string :name
      t.json :payload

      t.timestamps null: false
    end
  end
end
