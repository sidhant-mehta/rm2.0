class MemberMentorApplication < ActiveRecord::Base
  before_save validate :cv_check
  
  attr_accessible :member_id, :mentor_id, :status
  attr_accessor :user
 

def cv_check
  unless ! user.cv.blank?
    errors.add(:member_id, "You must have uploaded a CV. Please upload your CV via the profile page in the dashboard.")
  end
end

=begin
def can_member_make_application_checks (member_id)
error_msg = ""

    if member_id == -1 #is the member logged in?
      return false
    else
      # do other checks
      #check if CV uploaded.
    end
  end
=end
end