class AddDefaultValueToExternalAndInternal < ActiveRecord::Migration
  def up
    change_column :projects, :external, :boolean, :default => true
    change_column :projects, :internal, :boolean, :default => true
    change_column :mentors, :external, :boolean, :default => true
    change_column :mentors, :internal, :boolean, :default => true
end

def down
    change_column :projects, :external, :boolean, :default => nil
    change_column :projects, :internal, :boolean, :default => nil
    change_column :mentors, :external, :boolean, :default => nil
    change_column :mentors, :internal, :boolean, :default => nil
end
end
