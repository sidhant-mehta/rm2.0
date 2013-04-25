class ApplicationController < ActionController::Base
  protect_from_forgery

def can_member_make_application_checks (member_id)

  if member_id == -1
    return false
  else
    # do other checks
    return true
  end
  
end 



end
