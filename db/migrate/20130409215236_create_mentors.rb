class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.string :fname
      t.string :lname
      t.string :role_title
      t.string :sector_ids
      t.string :organisation
      t.date :closing_date
      t.string :location
      t.string :description
      t.string :email
      t.string :telephone
      t.string :image
      t.boolean :draft

      t.timestamps
    end
  end
end
