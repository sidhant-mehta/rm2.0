class AddUnconfirmedEmailToMember < ActiveRecord::Migration
  def change
    add_column :members, :unconfirmed_email, :string
  end
end
