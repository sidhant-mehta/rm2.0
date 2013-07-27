module MembersHelper

def isMentor? (email)
  m = Mentor.find_by_email (email)
  return !m.nil?
end

end
