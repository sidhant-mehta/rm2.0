class AddSettingsReceiveEmailUpdatesAndSettingsPassInfoToEmploymentAgenciesAndSettingsMentoringHighschoolAndSettingsPassInfoToMarketingToMember < ActiveRecord::Migration
  def change
    add_column :members, :settings_receive_email_updates, :boolean
    add_column :members, :settings_pass_info_to_employment_agencies, :boolean
    add_column :members, :settings_mentoring_highschool, :boolean
    add_column :members, :settings_pass_info_to_marketing, :boolean
  end
end
