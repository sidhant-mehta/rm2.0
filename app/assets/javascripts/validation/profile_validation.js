function validateForm()
{
var fname=document.forms["member_profile_form"]["fname"].value;
var lname=document.forms["member_profile_form"]["lname"].value;
var email=document.forms["member_profile_form"]["email"].value;
var dob=document.forms["member_profile_form"]["dob"].value;

/*First name*/
if (fname==null || fname=="")
  {
  alert("First name must be filled out");
  return false;
  }

if (fname.length < 3)
  {
  alert("First name must be at least 3 characters");
  return false;
  }
  
/*Last name*/
if (lname==null || lname=="")
  {
  alert("Last name must be filled out");
  return false;
  }

if (lname.length < 3)
  {
  alert("Last name must be at least 3 characters");
  return false;
  }

if (!checkEmail())
	return false;
  
if (!checkDOB())
	return false;
else
	return true;
}

function checkEmail()
{
	if (email==null || email=="")
	  {
	  alert("Email must be filled out");
	  return false;
	  }
	else
	  {
		var email_pattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    if (email_pattern.test(email.value)==false)
	    	{
	    		alert("Please enter a valid email address")
	    		return false;
	    	}
	    else
	    	return true;
	  }
}

 function checkDOB() 
 {
	 if (dob == null || dob =="")
	 {
	 	alert("Date of birth field must be filled out, as DD-MM-YYYY")
	 	return false;
	 }
	 else
	 {
	 	//var dob_pattern =/^([0-9]{2})/([0-9]{2})/([0-9]{4})$/;
		if(dob_pattern.test(dob.value) == false)
		{
		    alert("Please enter a valid Date of birth in the form dd-mm-yyyy");
			return false;
		}
		else
		{
			return true;
		}
		
	 }
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