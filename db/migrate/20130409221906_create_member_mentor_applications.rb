class CreateMemberMentorApplications < ActiveRecord::Migration
  def change
    create_table :member_mentor_applications do |t|
      t.integer :member_id
      t.integer :mentor_id
      t.string :status

      t.timestamps
    end
  end
end
