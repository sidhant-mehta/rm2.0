class MemberJobApplication < ActiveRecord::Base
  attr_accessible :job_id, :member_id, :status
end
