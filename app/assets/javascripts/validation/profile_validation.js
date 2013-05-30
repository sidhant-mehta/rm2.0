function validateForm()
{
	if( checkNumberOfSelectedSectors() ==true) // && checkHearAboutUs() == true)
		return true;
	else
	{
		alert("Please select a maximum of 3 sectors.")		
		return false;
	}
}

 function checkNumberOfSelectedSectors()
 {
 	var sector_ids_element = document.getElementById("sector_ids");
 	var count =0;
 	
 	 for (i=0; i<sector_ids_element.options.length; i++)
 	 {
	 	 if (sector_ids_element.options[i].selected ==true )
	 	 {
	 	 	count++;
	 	 }
	 } 	
	return (count < 4);
 }

  /*where did you hear about us*/
 function checkHearAboutUs()
 {
 	var hear_about_us = document.getElementById("hear_about_us");
	var hear_about_us_other = document.getElementById("hear_about_us_other")
	
	if (hear_about_us.options[hear_about_us.selectedIndex].value == "Other (please state)" )
	{
		hear_about_us_other.style.visibility ="visible";
	}
	else
	{
		hear_about_us_other.style.visibility ="hidden";
	}
	 
	 return false;
}