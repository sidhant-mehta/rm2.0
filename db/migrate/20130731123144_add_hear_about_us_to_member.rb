class AddHearAboutUsToMember < ActiveRecord::Migration
  def change
    add_column :members, :hear_about_us, :string
  end
end
