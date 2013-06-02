module MentorsHelper
  def getSectors(mentor)
debugger
    sectors=[]
      Sector.all.each_with_index do |s,i|
        sectors << Sector.find(s)
      end
       if mentor.sector_ids.blank?
       else   
           mentor_sectors_ids_array = mentor.sector_ids.split(",")
           mentor_sectors_ids = [] #need to initialize this array first
           mentor_sectors_ids_array.each_with_index do |s, i| 
             mentor_sectors_ids << Sector.find(s).id
       end
      end
    return mentor_sectors_ids
  end


  def sectorsHTML(mentor)
debugger
    sectors =[] 
    secotors = getSectors(mentor)
    sectors.each_with_index do |s,i|
      print "<p> #{s} </p>".html_safe
    end
    
  end



end
