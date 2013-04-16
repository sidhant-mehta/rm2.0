class AddFnameAndLnameToMembers < ActiveRecord::Migration
  def change
    add_column :members, :fname, :string
    add_column :members, :lname, :string
  end
end
