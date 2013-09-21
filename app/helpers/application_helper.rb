module ApplicationHelper

def countMentorApplications(id)
  return MemberMentorApplication.where(:mentor_id => id).count
end

def countProjectApplications(id)
  return MemberProjectApplication.where(:project_id => id).count
end


def getOrganisation (email)
  dom = getDomain (email)  
  org = OrganisationEmailDomain.where(domain: dom )
  
  if org.blank? 
    org = -1
  else
    org = org[0].organisation
  end
  return org
end

def getDomain (email)
  return email.split('@')[1]
end


  def getSectors(obj)
    sectors=[]
      Sector.all.each_with_index do |s,i|
        sectors << Sector.find(s)  
        
      end
       if obj.sector_ids.blank?
       else   
           obj_sectors_ids_array = obj.sector_ids.split(",")
           obj_sectors_names = [] #need to initialize this array first
           obj_sectors_ids_array.each_with_index do |s, i| 
             obj_sectors_names << Sector.find(s).name rescue ActiveRecord::RecordNotFound
                
       end
      end
    return obj_sectors_names
  end
  
  
  def sectorsHTML(obj)
    sectors =[] 
    sectors = getSectors(obj)
    if (!sectors.nil?)  
        sectors = sectors.join(", ")
    end         
     return sectors
  end


  def locationHTML(obj)
    if !obj.location.blank?
        return Location.find(obj.location).name
    else
      return ""
    end 
  end

  def organisationProfileExists?(org)
    if EmployerProfile.exists?(:name => org)
      return employer_profile_path(EmployerProfile.find_by_name(org))
    else
      return -1
    end
  end

end