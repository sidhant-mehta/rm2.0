class AddSlugToMentors < ActiveRecord::Migration
  def change
    add_column :mentors, :slug, :string
  end
end
