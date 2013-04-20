class CreateMemberProjectApplications < ActiveRecord::Migration
  def change
    create_table :member_project_applications do |t|
      t.integer :member_id
      t.string :project_id
      t.string :status

      t.timestamps
    end
  end
end
