class AddSectorIdsAndLocationToEmployerProfiles < ActiveRecord::Migration
  def change
    add_column :employer_profiles, :sector_ids, :string
    add_column :employer_profiles, :location, :string
  end
end
