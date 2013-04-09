class MemberProject < ActiveRecord::Base
  attr_accessible :member_id, :project_id, :status
end
