class CreateVolunteerRegistration < ActiveRecord::Migration
  def change
    create_table :volunteer_registrations do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false
      t.string :address_string, null: false
      t.string :email_address, null: false
      t.text :interests, null: false
      t.text :volunteer_profile, null: false
      t.string :employer
      t.string :job_title
    end
  end
end
