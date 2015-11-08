class CreateFeedback < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :subject, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number
      t.string :address
      t.string :comment, null: false
    end
  end
end
