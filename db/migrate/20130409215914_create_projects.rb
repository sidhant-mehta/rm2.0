class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :project_leader
      t.string :sector_ids
      t.string :organisation
      t.date :closing_date
      t.string :location
      t.string :description
      t.string :email
      t.string :telephone
      t.boolean :draft

      t.timestamps
    end
  end
end
