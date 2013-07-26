module MentorsHelper
  def getSectors(mentor)
    sectors=[]
      Sector.all.each_with_index do |s,i|
        sectors << Sector.find(s)
      end
       if mentor.sector_ids.blank?
       else   
           mentor_sectors_ids_array = mentor.sector_ids.split(",")
           mentor_sectors_names = [] #need to initialize this array first
           mentor_sectors_ids_array.each_with_index do |s, i| 
             mentor_sectors_names << Sector.find(s).name
       end
      end
    return mentor_sectors_names
  end


  def sectorsHTML(mentor)
    sectors =[] 
    sectors = getSectors(mentor)
    if (!sectors.nil?)  
        sectors = sectors.join(" ")
    end     
     return sectors
  end



end
