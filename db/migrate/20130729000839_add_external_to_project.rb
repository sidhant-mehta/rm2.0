class AddExternalToProject < ActiveRecord::Migration
  def change
    add_column :projects, :external, :boolean
  end
end
