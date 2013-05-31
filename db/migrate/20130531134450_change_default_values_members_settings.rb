class ChangeDefaultValuesMembersSettings < ActiveRecord::Migration

  def change
    change_column_default :members, :settings_receive_email_updates, :boolean, :default => false
    change_column_default :members, :settings_pass_info_to_employment_agencies, :boolean, :default => false
    change_column_default :members, :settings_mentoring_highschool, :boolean, :default => false
    change_column_default :members, :settings_pass_info_to_marketing, :boolean, :default => false
  end
  
end
