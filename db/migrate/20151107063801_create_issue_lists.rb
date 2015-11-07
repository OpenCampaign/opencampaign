class CreateIssueLists < ActiveRecord::Migration
  def change
    create_table :issue_lists do |t|
      t.integer :position

      t.timestamps null: false
    end
  end
end
