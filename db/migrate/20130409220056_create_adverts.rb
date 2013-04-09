class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string :name
      t.string :image
      t.string :sector_ids

      t.timestamps
    end
  end
end
