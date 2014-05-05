//set up markers 
var myMarkers = {"markers": [
    {"latitude": "25.051103", "longitude":"121.514198", "icon": "img/map-marker2.png"}
  ]
};

//set up map options
$("#map").mapmarker({
  zoom  : 15,
  center  : '103 台灣台北市大同區華陰街 227 巷 7 號',
  markers  : myMarkers
});