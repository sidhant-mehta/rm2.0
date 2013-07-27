class AddInternalToMentor < ActiveRecord::Migration
  def change
    add_column :mentors, :internal, :boolean
  end
end
