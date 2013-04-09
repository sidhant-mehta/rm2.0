class CreateClientMentors < ActiveRecord::Migration
  def change
    create_table :client_mentors do |t|
      t.integer :client_id
      t.integer :mentor_id

      t.timestamps
    end
  end
end
