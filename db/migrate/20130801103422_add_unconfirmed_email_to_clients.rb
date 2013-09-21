class AddUnconfirmedEmailToClients < ActiveRecord::Migration
  def change
    add_column :clients, :unconfirmed_email, :string
  end
end
