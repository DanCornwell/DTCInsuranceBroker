// JavaScript Document - contains methods for displaying the form to the user

// The current form we are looking at
var currentForm = 'person';
// The current number of incidents the user indicates they have had
var prev_incidents = parseInt("0",10);

/**
 * Method that displays the different forms by hiding and revealing each form
 * @param form - the form to be displayed
 */
function showForm(form) {

   document.getElementById(currentForm).style.display = 'none';
   // If statement to handle users without accidents travelling between forms
   if(document.getElementById(form) === document.getElementById("history_incidents")) {
       // If there are 0 incidents dont show the incidents form
		if(parseInt(document.getElementById("number_incidents").value,10) == 0) {
            // If we are at incident history form, go to policy form else go to history form
			if(document.getElementById(currentForm) === document.getElementById("history")) {
				form = "policy";	
			}
			else(form = "history");
		}
		addIncidentForms(document.getElementById("number_incidents").value);
   }
   // Sets next form as visible
   document.getElementById(form).style.display = 'block';
   // Change currentform variable to the new form
   currentForm = form;
   // Scroll to top of page
   scrollTo(0,0);
   // Clean errors box
   cleanErrors();

 }

/**
 * Validates the current form, if it passes append the summary and move to next form
 * @param form - the form to be validated
 */
function validate(form) {

    // Scroll to top of page
    scrollTo(0,0);
    // Clean errors box
    cleanErrors();
	if(validateForm(currentForm)) {
		appendSummary(currentForm);
		showForm(form);
	}
	
}


// Dynamically adds or removes a number of incident forms to match the amount of incidents the user specified
function addIncidentForms(num) {
	// The number of incidents the user has been involved in
	incidents = parseInt(num,10);
	// The div element where these incidents will go
	var container = document.getElementById("incidents");
	// If the number supplied by the user is smaller than the current incidents in the form
	if(incidents < prev_incidents) {
		
		// Trim the extra forms
		for(i=prev_incidents; i>incidents; i--) {
			// Use 9 since each incident form uses 9 elements (1 label and 1 break line pre incident, + 1 extra break line = 4(2)+1 = 9)
			for(j=0;j<13;j++) {
				// Remove elements from the back
				container.removeChild(container.lastChild);
			}
		}
	}
	// Else if the number supplied is greater than the current incidents in the form
	else if(incidents > prev_incidents) {
	
		var lower = prev_incidents + +1;
		var upper = incidents + +1;
		
		// Add the new elements starting from 1 more than the current number of incidents
		for(k=lower;k<upper;k++) {
			// The date input
			var date_label = document.createElement('label');
			date_label.setAttribute('for','incident_date'+k);
			var date_input = document.createElement("input");
			date_input.setAttribute('type',"date");
			date_input.setAttribute('id',"incident_date"+k);
            date_input.setAttribute('name',"incident_date"+k);
            date_input.className = "data accident";
			date_label.appendChild(document.createTextNode("Date of incident "+k+": "));
			container.appendChild(date_label);
			container.appendChild(date_input);
			container.appendChild(document.createElement("br"));
		
			// The sum of claim input
			var num_label = document.createElement('label');
			num_label.setAttribute('for',"total_sum"+k);
			var num_input = document.createElement("input");
			num_input.setAttribute('type',"number");
			num_input.setAttribute('id',"claim_sum"+k);
            num_input.setAttribute('name',"claim_sum"+k);
            num_input.setAttribute('min','1');
			num_input.setAttribute('step','200');
			num_input.className = "data"; 
			num_input.setAttribute('value',"200");
			num_label.appendChild(document.createTextNode("Total sum of claim "+k+" £:"));
			container.appendChild(num_label);
			container.appendChild(num_input);
			container.appendChild(document.createElement("br"));
			
			// The type of incident input
			var type_label = document.createElement('label');
			type_label.setAttribute('for',"type_incident"+k);
			var type_input = document.createElement('select');
			type_input.setAttribute('id',"incident_type"+k);
            type_input.setAttribute('name',"incident_type"+k);
            type_input.className = "data";
			type_input.options[0] = new Option("Head-On Collision","Head-On Collision",true,false);
			type_input.options[1] = new Option("Single Vehicle Collision","Single Vehicle Collision",false,false);
			type_input.options[2] = new Option("Intersection Collision","Intersection Collision",false,false);
			type_label.appendChild(document.createTextNode("Type of incident "+k+": "));
			container.appendChild(type_label);
			container.appendChild(type_input);
			container.appendChild(document.createElement("br"));
		
			// The description of incident input
			var description_label = document.createElement('label');
			description_label.setAttribute('for',"textfield"+k);
			var description_input = document.createElement('input');
			description_input.setAttribute('type',"textfield"+k);
			description_input.setAttribute('id',"description");
            description_input.setAttribute('name',"description");
            description_input.className = "data";
			description_label.appendChild(document.createTextNode("Description of incident "+k+": "));
			container.appendChild(description_label);
			container.appendChild(description_input);
			container.appendChild(document.createElement("br"));
			container.appendChild(document.createElement("br"));

		}
	}
	// Set prev_incidents to equal incidents
	prev_incidents = incidents;
}

/**
 * Appends the data of a form to the summary field
 *
 * @param form - form to be appended
 */
function appendSummary(form) {

	// Determine the correct container, returns if we are in the summary
	var container="";
	if(form=='person'){container='person_data'}
	else if(form=='vehicle'){container='vehicle_data'}
	else if(form=='history'){container='num_incidents_data'}
	else if(form=='history_incidents'){container='incidents_data'}
	else if(form=='policy'){container='policy_data'}
	else return
	
	// Clear the container before filling it. This is to account for going back in the form
	document.getElementById(container).innerHTML = "";
	
	// The data the user submits
	var data = document.getElementById(form).getElementsByClassName('data');
	
	// Get the data values out of the data.
	var dataValues = new Array();
	for(i=0;i<data.length;i++) {
		// Get only the 'checked' value of the radio buttons
		if(data[i].type === "radio") {
			if(data[i].checked) {
				dataValues.push(data[i].value);
			}
		}
		// Get a yes if checked, no if not
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
			dataValues.push(data[i].value);
		}	
	}
	
	// Get the labels which the datas sit in
	var labels = document.getElementById(form).getElementsByTagName('label');
	// For the amount of values we have, should probably have a validation checking that dataValues.length == labels.length
	for(i=0;i<dataValues.length;i++) {
		// Get the labelText. If child nodes exist in the label, get the first one (which should be the text before the input)
		// If not return the data values' type, so it sort of displays something meaningful
		var labelText = labels[i].childNodes.length > 0 ? labels[i].childNodes[0].textContent : dataValues[i].type;
		// Append the label text with the value to the container
		document.getElementById(container).appendChild(document.createTextNode(labelText+" "+dataValues[i]));	
		// Append a break line to the container
		document.getElementById(container).appendChild(document.createElement("br"));	
	}
}