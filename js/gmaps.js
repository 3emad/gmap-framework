/***
 * Gmaps V0.3
 * Gmaps Basic functionailty 
 * 
 * Help:
 * var callBackUrl THIS IS A MUST SET
 * 
 */

  var map;
  var bounds = new google.maps.LatLngBounds();
  var gicons = [];
  var markers = [];
  var infoWindow;
  var locationSelect;
  var initialLocation;
  var defaultZoom = 14;
  var searchUrl = '';
  
  var browserSupportFlag =  new Boolean();
  var myMarkers = [];
  
  // Used to set Marker on location
  var setMyLocation = true;

  // [Option] Icon images
  gicons["here"] = "http://maps.google.com/mapfiles/arrow.png";
  gicons["Custom"]  = "http://google-maps-icons.googlecode.com/files/menatwork.png";
  gicons["Dump"] = "http://google-maps-icons.googlecode.com/files/icyroad.png";
  gicons["Park"] = "http://google-maps-icons.googlecode.com/files/zoo.png";
  gicons["Dog"] = "http://google-maps-icons.googlecode.com/files/pets.png";
  gicons["Stable"] = "http://google-maps-icons.googlecode.com/files/horseriding.png";
  gicons["Vet"] = "http://google-maps-icons.googlecode.com/files/vet.png";
  gicons["Bar/Nightlife"] = "http://google-maps-icons.googlecode.com/files/bar.png";
  gicons["Boarding/Kennel"] = "http://google-maps-icons.googlecode.com/files/bar.png";
  gicons['Photography'] = "http://google-maps-icons.googlecode.com/files/photography.png";
  gicons['Pet Boutique'] = "http://google-maps-icons.googlecode.com/files/shoppingmall.png";
  gicons['Restaurant/Cafe'] = "http://google-maps-icons.googlecode.com/files/restaurant.png";
  gicons['Pet-Friendly Store'] = "http://google-maps-icons.googlecode.com/files/pets.png";
  gicons['Rescue Organizations'] = "http://google-maps-icons.googlecode.com/files/truck.png";
  gicons['Groomer/Spa'] = "http://google-maps-icons.googlecode.com/files/hairsalon.png";
  
  function initialize() {
     	
      var myOptions = {
    	      zoom: defaultZoom,
    	      center: userDefined,
    	      mapTypeId: google.maps.MapTypeId.ROADMAP
    	    };

      
	    map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
	    infoWindow = new google.maps.InfoWindow();
	    
	    map.setCenter(userDefined);
	    if(setMyLocation){
	    	createMarker(userDefined.b,userDefined.c, 'here', 'Your Currently Here','');
	    }
	    
	    // auto locate me
	    if(navigator.geolocation) {
	        browserSupportFlag = true;
	        navigator.geolocation.getCurrentPosition(function(position) {
	          initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
	          map.setCenter(initialLocation);
	          clearMyMarker();
	          createMarker(initialLocation.b,initialLocation.c, 'here', 'Your Currently Here','');
	        }, function() {
	          handleNoGeolocation(browserSupportFlag);
	        });
	      } else if (google.gears) {
	    	    browserSupportFlag = true;
	    	    var geo = google.gears.factory.create('beta.geolocation');
	    	    geo.getCurrentPosition(function(position) {
	    	      initialLocation = new google.maps.LatLng(position.latitude,position.longitude);
	    	      map.setCenter(initialLocation);
	    	      clearMyMarker();
	    	      createMarker(initialLocation.b,initialLocation.c, 'here', 'Your Currently Here','');
	    	    }, function() {
	    	      handleNoGeoLocation(browserSupportFlag);
	    	    });
	    	 // Browser doesn't support Geolocation
	      } else {
	        browserSupportFlag = false;
	        handleNoGeolocation(browserSupportFlag);
	      }
	      

	    function handleNoGeolocation(errorFlag) {
	        if (errorFlag == true) {
	          alert("Geolocation service failed.");
	          initialLocation = userDefined;
	        }
	        map.setCenter(initialLocation);
	     }
	    
	    /*locationSelect = document.getElementById("locationSelect");
	      locationSelect.onchange = function() {
	        var markerNum = locationSelect.options[locationSelect.selectedIndex].value;
	        if (markerNum != "none"){
	          google.maps.event.trigger(markers[markerNum], 'click');
	        }
	      };
	    */  
	  } // initizliation ends

  
  // beginning prodedural calls
  function reloadMap(markers,boundIt) {
    //infoWindow.close();
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(map);
      //document.getElementById('write').write(markers[i]);
    }
   
    if(boundIt == undefined || boundIt === true){
    	//map.panTo(bounds.getCenter());
    	map.fitBounds(bounds);
    	map.panToBounds(bounds);
	    if(map.getZoom() > 15 ){
			map.setZoom(15);
	    }
    }
  }

  function createMarker(lat, lng, type, title, html, draggable) {
      if( html == undefined ){
    	  html = '';
      }
      if( draggable == undefined ){
    	  draggable = false;
      }

      var point = new google.maps.LatLng(lat,lng);
      var options = {
      	    map: map,
      	    position: point,
      	    title: title,
      	    icon: '',
      	    draggable: draggable
        };

      if(gicons[type] != undefined){
        	options.icon = gicons[type];
        }
      
      var html = "<h3>" + title + "</h3>" + "<p>" + html + "<p>"; 
	  var marker = new google.maps.Marker(options);
	  google.maps.event.addListener(marker, 'click', function() {
	    infoWindow.setContent(html);
	    infoWindow.open(map, marker);
	  });
	  bounds.extend(point);
	  markers.push(marker);
	}

  // if "searchUrl" is sat to false, it will disable ajax parser
  function searchLocations(searchUrl, enableUserPosition) {
     var address = document.getElementById("addressInput").value;
     var geocoder = new google.maps.Geocoder();
     
     if(searchUrl == undefined ){
    	 // NO AJAX, Just take me there!
    	 searchUrl = false;
	 }else{
		 searchUrl = callbackUrl+searchUrl+'?';
	 }
     
	 if(enableUserPosition == undefined){
		 enableUserPosition = true;
	 }
	 
     geocoder.geocode({address: address}, function(results, status) {
       if (status == google.maps.GeocoderStatus.OK) {
    	// POSTION Object of the Search
    	center = results[0].geometry.location;
    	if(enableUserPosition && searchUrl != false){
    		searchUrl = searchUrl+'lat=' + center.lat() + '&lng=' + center.lng();
    	}
        searchLocationsNear(searchUrl);
       } else {
         alert(address + ' not found');
       }
     });
   }

  	function searchLocationsNear(searchUrl) {
	     //var radius = document.getElementById('radiusSelect').value;
	     // var searchUrl = 'phpsqlsearch_genxml.php?lat=' + center.lat() + '&lng=' + center.lng() + '&radius=' + radius;
  		 if(!searchUrl){
 			clearLocations(markers);
			// Ur own marker
			createMarker(center.lat(),center.lng(), 'here', 'Your Currently Here','',json.myPostionDraggable);
			// Plot the markers
			reloadMap(markers); 
  		 }else{
  			json.searchUrl = searchUrl;
  			json.call();
  			//createOption(name, distance, i);
  		 }
	     
	       /*locationSelect.style.visibility = "visible";
	       locationSelect.onchange = function() {
	         var markerNum = locationSelect.options[locationSelect.selectedIndex].value;
	         google.maps.event.trigger(markers[markerNum], 'click');
	       };
	      });*/
	    }

  	
	// JSON class function
	function json() {
		// === Parse the JSON document ===
		var json = this;
		var jsonData = '';
		this.searchUrl = '';
		this.myPostionDraggable = false;
		
		// TO Override the URL
		this.url = function(url){
			return url;
		};
		
		//A function to read the data
		this.call = function() {
		  var request = window.ActiveXObject ?
		      new ActiveXObject('Microsoft.XMLHTTP') :
		      new XMLHttpRequest;
		
		  request.onreadystatechange = function() {
		    if (request.readyState == 4) {
		      request.onreadystatechange = function(){};
		      
		      // ready state triggers this stage, that i hade to put it to be the last function
		      json.parse(request.responseText);
		      return request.responseText;
		    }
		  };
		  // overide for Ajax
		  request.open('GET',this.url(json.searchUrl), true);
		  request.send(null);
		};
		
		// MUST be Overridden
		this.processJson = function (jsonData){
			for (var i=0; i<jsonData.length; i++) {
				var name = jsonData[i].name;
				var desc = jsonData[i].description;
				if(desc == undefined){
					desc = '';
				}else{
					desc = truncateString(desc)+'...<a href="'+appUrl+'group/view/'+jsonData[i].networkId+'">Visit '+jsonData[i].placeType.name+'</a>';
				}
				createMarker(jsonData[i].location.latitude, jsonData[i].location.longitude, jsonData[i].placeType.name, name.replace(/[\r\t\n]/,' '), desc.replace(/[\r\t\n]/,' ') );
			  }
		};
		  
		this.parse = function (responseJSON){
		  	var jsonData = eval('(' +  responseJSON + ')');
		    if(jsonData == null){
				alert('Finding locatioin Failed, Please Try again');
			}else{
				clearLocations(markers);
				// Ur own marker
				createMarker(center.lat(),center.lng(), 'here', 'Your Currently Here','',this.myPostionDraggable);
				// Plot the markers
				this.processJson(jsonData);
				reloadMap(markers);
			}
		};
		  // put the assembled side_bar_html contents into the side_bar div
		  //document.getElementById("side_bar").innerHTML = side_bar_html;
	}
	// this allows us to 
	var json = new json();
	// Done Json Class
  	

  
  function clearLocations(markers) {
    infoWindow.close();
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }
    markers.length = 0;
    bounds = new google.maps.LatLngBounds();
    /*locationSelect.innerHTML = "";
    var option = document.createElement("option");
    option.value = "none";
    option.innerHTML = "See all results:";
    locationSelect.appendChild(option);
    locationSelect.style.visibility = "visible";*/
  }

  
  function truncateString(str){
	  return str.substring(0,90);
  }
  
  // Creating a New Marker on button
  function addPlace(){
	  var marker = new google.maps.Marker({
		    map: map,
		    position: map.getCenter(),
		   	icon: gicons["dog"],
		   	draggable: true
		  });
	  myMarkers.push(marker);
  }        

  function clearMyMarker(){
	  //var answer = confirm ("Do you want to clear ALL your markers?")
	  //if (answer){
	  	clearLocations(myMarkers);
	  //}
  }

  function saveMarkers(){
		document.getElementById('myMarkers').value = myMarkers;
  }