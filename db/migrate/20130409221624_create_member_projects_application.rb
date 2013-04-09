class CreateMemberProjectsApplication < ActiveRecord::Migration
  def change
    create_table :member_projects_application do |t|
      t.integer :member_id
      t.integer :project_id
      t.string :status

      t.timestamps
    end
  end
end
