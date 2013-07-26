module ProjectsHelper
  def getSectors(project)
    sectors=[]
      Sector.all.each_with_index do |s,i|
        sectors << Sector.find(s)
      end
       if project.sector_ids.blank?
       else   
           project_sectors_ids_array = project.sector_ids.split(",")
           project_sectors_names = [] #need to initialize this array first
           project_sectors_ids_array.each_with_index do |s, i| 
             project_sectors_names << Sector.find(s).name
       end
      end
    return project_sectors_names
  end
  
  
  def sectorsHTML(project)
    sectors =[] 
    sectors = getSectors(project)
    if (!sectors.nil?)  
        sectors = sectors.join(" ")
    end         
     return sectors
  end

end
