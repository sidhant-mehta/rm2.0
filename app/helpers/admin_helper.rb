module AdminHelper
def getMember(id)

  return Member.find(id)
end
end
