class AddSalaryToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :salary, :string
  end
end
