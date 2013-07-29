class AddUnconfirmedEmailToClient < ActiveRecord::Migration
    def change
    change_table(:client) do |t| 
      t.confirmable 
    end
    add_index  :client, :confirmation_token, :unique => true 
  end
end
