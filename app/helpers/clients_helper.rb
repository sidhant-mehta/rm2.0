module ClientsHelper
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
             obj_sectors_names << Sector.find(s).name
       end
      end
    return obj_sectors_names
  end
  
  
  def sectorsHTML(obj)
    sectors =[] 
    sectors = getSectors(obj)
         
    sectors = sectors.join(" ")
     return sectors
  end


end
