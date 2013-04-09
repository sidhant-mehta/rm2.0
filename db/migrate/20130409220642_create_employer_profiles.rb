class CreateEmployerProfiles < ActiveRecord::Migration
  def change
    create_table :employer_profiles do |t|
      t.string :name
      t.string :bio

      t.timestamps
    end
  end
end
