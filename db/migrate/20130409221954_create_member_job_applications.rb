class CreateMemberJobApplications < ActiveRecord::Migration
  def change
    create_table :member_job_applications do |t|
      t.integer :member_id
      t.integer :job_id
      t.string :status

      t.timestamps
    end
  end
end
