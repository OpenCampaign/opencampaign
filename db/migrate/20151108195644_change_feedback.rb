class ChangeFeedbackNameAndCommentType < ActiveRecord::Migration
  def self.up
    rename_column :feedbacks, :email, :email_address
  end

  def change
    change_table :feedbacks do |t|
      t.change :comment, :text, null: false
    end
  end

  def self.down
    rename_column :feedbacks, :email_address, :email
  end
end
