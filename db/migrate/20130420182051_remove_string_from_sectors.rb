class RemoveStringFromSectors < ActiveRecord::Migration
  def up
    remove_column :sectors, :string
  end

  def down
    add_column :sectors, :string, :string
  end
end
