class MemberMentorApplication < ActiveRecord::Base
  belongs_to :mentors
  belongs_to :members
  
  before_save validate :cv_check
  
  attr_accessible :member_id, :mentor_id, :status
  attr_accessor :user
 

def cv_check
  unless ! user.cv.blank?
    errors.add(:member_id, "You must have uploaded a CV. Please upload your CV via the profile page in the dashboard.")
  end
end

end