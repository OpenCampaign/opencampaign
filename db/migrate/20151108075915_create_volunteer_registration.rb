class CreateVolunteerRegistration < ActiveRecord::Migration
  def change
    create_table :volunteer_registrations do |t|
      t.belongs_to :user, index: true
      t.text :interests, null: false
      t.text :volunteer_profile, null: false
      t.string :employer
      t.string :job_title
    end
  end
end
