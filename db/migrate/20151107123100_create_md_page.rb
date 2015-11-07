class CreateMdPage < ActiveRecord::Migration
  def change
    create_table :md_pages do |t|
      t.column :title, :string, null: false
      t.column :content, :text
      t.timestamps
    end
  end
end

