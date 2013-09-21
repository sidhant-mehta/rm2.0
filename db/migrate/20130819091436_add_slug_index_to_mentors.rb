class AddSlugIndexToMentors < ActiveRecord::Migration
  def change
    add_index :mentors, :slug
  end
end
