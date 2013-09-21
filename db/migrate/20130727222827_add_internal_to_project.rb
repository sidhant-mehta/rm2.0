class AddInternalToProject < ActiveRecord::Migration
  def change
    add_column :projects, :internal, :boolean
  end
end
