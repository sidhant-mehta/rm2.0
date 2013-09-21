class AddExternalToMentor < ActiveRecord::Migration
  def change
    add_column :mentors, :external, :boolean
  end
end
