class AddDobGenderTelephoneLocationCourseCvToMembers < ActiveRecord::Migration
  def change
    add_column :members, :dob, :date
    add_column :members, :gender, :string
    add_column :members, :telephone, :string
    add_column :members, :sector_ids, :string
    add_column :members, :location, :string
    add_column :members, :employment_status, :string
    add_column :members, :academic_institution, :string
    add_column :members, :course, :string
    add_column :members, :cv, :string
  end
end
