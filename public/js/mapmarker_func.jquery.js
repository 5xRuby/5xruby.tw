		//set up markers 
		var myMarkers = {"markers": [
				{"latitude": "25.050888", "longitude":"121.516604", "icon": "img/map-marker2-thumb.png"}
			]
		};
		
		//set up map options
		$("#map").mapmarker({
			zoom	: 16,
			center  : '10349 台灣台北市大同區長安西路 150 號 11 樓之 1',
			markers	: myMarkers
		});

