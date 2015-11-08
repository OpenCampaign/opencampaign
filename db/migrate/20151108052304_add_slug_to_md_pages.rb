class AddSlugToMdPages < ActiveRecord::Migration
  def change
    add_column :md_pages, :slug, :string
  end
end
