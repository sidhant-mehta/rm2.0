class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :fname
      t.string :lname
      t.string :bio
      t.string :position
      t.string :image

      t.timestamps
    end
  end
end
