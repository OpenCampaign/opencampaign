class ChangeFeedbackNameAndCommentType < ActiveRecord::Migration
  def change
    change_table :feedbacks do |t|
      t.change :comment, :text, null: false
    end
    rename_column :feedbacks, :email, :email_address
  end
end
