class CreateOrganisationEmailDomains < ActiveRecord::Migration
  def change
    create_table :organisation_email_domains do |t|
      t.string :organisation
      t.string :domain

      t.timestamps
    end
  end
end
