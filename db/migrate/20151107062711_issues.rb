class Issues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.string :opinion, null: false
      t.integer :position
      t.timestamps
    end
  end
end
