class AddImagesToEmployerProfiles < ActiveRecord::Migration
  def change
    add_column :employer_profiles, :image, :string
  end
end
