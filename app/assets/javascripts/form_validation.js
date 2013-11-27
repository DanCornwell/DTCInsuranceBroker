// JavaScript Document

// Validates the user inputs and returns whether they have passed or failed.
// If failed display the errors to the user in order for them to be corrected
function validateForm(form) {
		
	var errors = new Array();
	
	// The data the user submits
	var data = document.getElementById(form).getElementsByClassName('data');
	// Get the labels which the data's sit in
	var labels = document.getElementById(form).getElementsByTagName('label');
	// The data the user submits
	var data = document.getElementById(form).getElementsByClassName('data');
	
	// Get the data values that the user has selected. This is different to the method 
	// in formDisplay, as it stores the whole data rather than just the data.value.
	// This is so we can test them below via type
	var dataValues = new Array();
	for(i=0;i<data.length;i++) {
		// Get only the 'checked' value of the radio buttons
		if(data[i].type === "radio") {
			if(data[i].checked) {
				dataValues.push(data[i]);
			}
		}
		// No real use here aside from placeholder
		else if(data[i].type === "checkbox") {
			if(data[i].checked==true) {
				dataValues.push("Yes");
			}
			else {
				dataValues.push("No");
			}
		}
		// Other data types aren't problimatic, so just push them into the array
		else{
			dataValues.push(data[i]);
		}	
	}

	for(i=0;i<dataValues.length;i++) {
	// Get the labelText. If child nodes exist in the label, get the first one (which should be the text before the input)
	// If not return the data values' type, so it sort of displays something meaningful
	var labelText = labels[i].childNodes.length > 0 ? labels[i].childNodes[0].textContent : dataValues[i].type;
	
	if(dataValues[i].type == 'date') {
		if(dataValues[i].id == "dob") {
	   		 if(!dobValidate(dataValues[i].value)) {
				  errors.push(labelText+" You must be at least 17 years old.");
			  }
		  }
		else if(dataValues[i].id =='start_date'){
			  if(!futureDateValidate(dataValues[i].value)) {
				  errors.push(labelText+" Policy date cannot be blank or in the past.");
			  }
		  }
		else if(dataValues[i].className =='data accident') {
			 if(!pastDateValidate(dataValues[i].value)) {
				  errors.push(labelText+" Accident date cannot be blank or in the future.");
			  }	
		}
	}
	  
	else if(dataValues[i].type == 'email') {
		  if(!emailValidate(dataValues[i].value)) {
			  errors.push(labelText+" Emails are required to be in the form character(s), @ symbol, characters (at least 2), . symbol and character (at least 2).");
		  }
	  }
	  
	else if(dataValues[i].type == 'number') {
		  if(!numValidate(dataValues[i].value)) {
				  errors.push(labelText+" Please use only number symbols between 0-9.");
			  }
	  }
	else if(dataValues[i].type == 'tel') {
		  if(!telValidate(dataValues[i].value)) {
				  errors.push(labelText+" Please use only number symbols between 0-9 and make sure there are 11 numbers.");
		  }
	  }

    else if(dataValues[i].type == 'text'){
		   if(dataValues[i].id == 'postcode') {
			  if(!postcodeValidate(dataValues[i].value)) {
				  errors.push(labelText+" Please use standard postcode form. (e.g SY235BT or SY38JT)");
			  }
		  }
		  else if(dataValues[i].className == 'data name') {
			  if(!nameValidate(dataValues[i].value)) {
				  errors.push(labelText+" A valid name is needed for your forename and surname. Please use only characters within the alphabet.");
			  }
		  }
          else if(dataValues[i].className == 'data code') {
              if(!codeValidate(dataValues[i].value)) {
                  errors.push(labelText+" A valid code is needed. Please use only lower case letters and make sure there are 8 letters altogether.");
              }
           }
		  else {
			  if(!textValidate(dataValues[i].value)) {
				  errors.push(labelText+" Field was blank or contained illegal characters.");	
			  }
		  }
	  }
			
	}
	// If no errors have been added to the errors array return true
	if(errors.length==0) {
		return true;
	}
	//  Else display errors, return false
	else {
		displayErrors(errors);
		return false;	
	}
}

// Check the retrieval form for errors, submitting if there are none
function validateRetrieve(form) {
    cleanErrors()
    if(validateForm(form)) {
        document.getElementById(form).submit()
    }

}

// Displays all the errors generated from the inputs
function displayErrors(errors) {
	// Sets the error column to visible
	document.getElementById('errorCol').style.display = 'block';
	// Get the error list
	var errorList = document.getElementById('errorList');
	// Add all errors to the error list
	for(i=0;i<errors.length;i++) {
		var errorItem = document.createElement('li');
		errorItem.innerHTML = errors[i];
		errorList.appendChild(errorItem);
	}
}

// Cleans the errors box
function cleanErrors() {
	document.getElementById('errorList').innerHTML = "";
	document.getElementById('errorCol').style.display = "none";
}

// Validates a date of birth by checking whether the user's age is bigger than 16 (can only start driving at 17)
function dobValidate(input) {
	
  var birthday = +new Date(input);
  var age =((Date.now() - birthday) / (31557600000));
  return (age>16);
}

// Validates a date by checking if the date is in the past or not 
function pastDateValidate(input) {
	var today = Date.now();
	return (new Date(input) < today);	
}

// Validates a date by checking if the date is in the future or not (policy cannot start before the current day)
function futureDateValidate(input) {
	var today = Date.now();
	return (new Date(input) >= today);
}

// Validates an email so that only standard emails are accepted
function emailValidate(input) {
	var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
	if(!emailFilter.test(input) || illegalChars.test(input)) {
		return false;	
	}
	else return true;
	
}

// Validates a postcode so only standard postcodes are accepted
function postcodeValidate(input) {
	input = input.replace(/^\s+|\s+$/g,'')
	var legalPattern = /[a-zA-Z]{2}[0-9]{1,2}\s{0,1}[0-9]{1}[a-zA-Z]{2}/;
	return legalPattern.test(input);
}

// Validates a number by checking whether it fails the NaN (not a number) method
function numValidate(input) {
	return !isNaN(parseInt(input,10));
}

// Validates a telephone number by checking whether it fails the NaN method and is 11 numbers long
function telValidate(input) {
	if(!isNaN(parseInt(input,10)) && input.length == 11) {
		return true;	
	}
	else return false;
}

// Validates a name by checking that only word characters are allowed
function nameValidate(input) {
	// Take only letters for names
	var legalChars = /[a-zA-Z]/;
	return legalChars.test(input);

}

// Validates a code by checking it is all lowercase and has a length of 8
function codeValidate(input) {
    var legalChars = /[a-z]/
    if(legalChars.test(input) && input.length == 8) {
        return true;
    }
    else return false;
}

// Validates a text by checking it is not blank and contains valid characters
function textValidate(input) {
	// A pattern to match character
	var legalChars = /^[A-Za-z0-9 _]*[A-Za-z0-9][A-Za-z0-9 _]*$/;
	return legalChars.test(input);	
}