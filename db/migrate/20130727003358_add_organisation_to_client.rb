class AddOrganisationToClient < ActiveRecord::Migration
  def change
    add_column :clients, :organisation, :string
  end
end
