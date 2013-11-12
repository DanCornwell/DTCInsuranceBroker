// JavaScript Document

// Creates an XML Http Request
function createRequest() {
  var result = null;
  if (window.XMLHttpRequest) {
    // FireFox, Safari, etc.
    result = new XMLHttpRequest();
    if (typeof result.overrideMimeType != 'undefined') {
      result.overrideMimeType('text/xml'); // Or anything else
    }
  }
  else if (window.ActiveXObject) {
    // MSIE
    result = new ActiveXObject("Microsoft.XMLHTTP");
  } 
  else {
    // No known mechanism -- consider aborting the application
  }
  return result;
}

function sendRequest() {
  var req = createRequest(); // defined above
  // Create the callback:
  req.onreadystatechange = function() {
	if (req.readyState != 4) return; // Not there yet
	if (req.status != 200) {
	  // Handle request failure here...
        window.location.href = "/error" ;
        return;
	}
	// Request successful, read the response
	var resp = req.responseText;
	// ... and use it as needed by your app.

  }	
  url = "http://posttestserver.com/post.php?dir=dtc";
  // url = "bogus.com";
  req.open("POST", url, true);
  req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
  req.send(getPostData());
}

function getPostData() {

	var data = document.getElementById('clientForm').getElementsByClassName("data");
	var post = "";
	for(i=0;i<data.length;i++){
		
		if(data[i].type === "radio") {
			if(data[i].checked) {
				post += data[i].name+'='+data[i].value+'&';
			}
		}
		else if(data[i].type === "checkbox") {
			if(data[i].checked==true) {
				post += data[i].id+'=yes&';
			}
			else {
				post += data[i].id+'=no&';
			}
		}
		else{
			post += data[i].id+'='+data[i].value+'&';
		}	
	}
    // Trim extra &
	post = post.substring(0, post.length - 1);
	return post;
}