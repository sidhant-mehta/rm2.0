class Member < ActiveRecord::Base
  has_many :member_mentor_applications, :dependent => :destroy
  has_many :mentors, :through => :member_mentor_applications
  has_many :member_project_applications, :dependent => :destroy
  has_many :projects, :through => :member_project_applications

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :fname, :lname, :dob, :unconfirmed_email, :gender, :telephone, :location, :academic_institution, :course, :sector_ids, :employment_status, :hear_about_us, :cv, :remove_cv
  mount_uploader :cv, CvUploader  

  EMAIL_REGEX = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i
  #DOB_REGEX = /^\d{1,2}[\/-]\d{1,2}[\/-]\d{4}$/
  
  validates_presence_of :fname, :message => "You need to inlcude a first name."
  validates_length_of :fname, :minimum => 3, :maximum => 15, :message => "Your first name must be between 3 and 15 characters."
  validates_format_of :fname, :with => /^[a-z ]+$/i, :message => "First name can only take letters."
  
  validates_presence_of :lname, :message => "You need to inlcude a last name."
  validates_length_of :lname, :within => 3..15,  :message => "Your last name must be between 3 and 15 characters."
  validates_format_of :lname, :with => /^[a-z ]+$/i, :message => "Last name can only take letters."
  
  validates_presence_of :email, :message=> "You must include an email address."
  validates_length_of :email, :within => 3..50, :message => "The email address must be between 3 and 50 characters."
  #validates_uniqueness_of :email, :message => "This email address has already been used."
  validates_format_of :email, :with => EMAIL_REGEX, :message => "This is an invalid email address."
  #validates_confirmation_of :email, :message  => ""
  
  validates_presence_of :dob, :message => "The date of birth must be included."
  validates_date :dob, :on_or_before => lambda { Date.current  }, :on_or_before_message => "The date of birth must before today."
  
  #validates_presence_of :password, :message => "Password cannot be blank."
  #validates_presence_of :password_confirmation, :message => "Password confirmation cannot be blank."
end