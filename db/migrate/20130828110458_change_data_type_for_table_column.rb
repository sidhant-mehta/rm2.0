class ChangeDataTypeForTableColumn < ActiveRecord::Migration
  def change
	change_table :employer_profiles do |t|  
	  t.change :bio, :text 
	end
  end
end