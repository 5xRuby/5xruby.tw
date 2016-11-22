		//set up markers 
		var myMarkers = {"markers": [
				{"latitude": "25.042473", "longitude":"121.513803", "icon": "/img/map-marker2-thumb.png"}
			]
		};
		
		//set up map options
		$("#map").mapmarker({
			zoom	: 16,
			center  : '10046 台灣台北市中正區衡陽路 7 號 5 樓',
			markers	: myMarkers
		});

