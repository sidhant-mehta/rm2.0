 function validateMemberForm()
{
	if( checkNumberOfSelectedSectors("member_sector_ids") ==true) // && checkHearAboutUs() == true)
		return true;
	else
	{
		alert("Please select a minimum of 1 and a maximum of 3 sectors.")		
		return false;
	}
}

 function validateMentorForm()
{
	if( checkNumberOfSelectedSectors("mentor_sector_ids") ==true) // && checkHearAboutUs() == true)
		return true;
	else
	{
		alert("Please select a minimum of 1 and a maximum of 3 sectors.")		
		return false;
	}
}

 function validateProjectForm()
{
	if( checkNumberOfSelectedSectors("project_sector_ids") ==true) // && checkHearAboutUs() == true)
		return true;
	else
	{
		alert("Please select a minimum of 1 and a maximum of 3 sectors.")		
		return false;
	}
}
 
 function checkNumberOfSelectedSectors(obj)
 {
 	var sector_ids_element = document.getElementById(obj);
 	var count =0;
 	
 	 for (i=0; i<sector_ids_element.options.length; i++)
 	 {
	 	 if (sector_ids_element.options[i].selected ==true )
	 	 {
	 	 	count++;
	 	 }
	 } 	
	return (count < 4 && count > 0);
 }