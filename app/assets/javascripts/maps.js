function initMap(locations) {
    var myCoords = new google.maps.LatLng(locations[0][1], locations[0][2]);
    var mapOptions = {
    center: myCoords,
    zoom: 14
    };

    var infowindow =  new google.maps.InfoWindow({});
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    var marker, count;

    for (count = 1; count < locations.length; count++) {
        marker = new google.maps.Marker({
          position: new google.maps.LatLng(locations[count][1], locations[count][2]),
          map: map,
          title: locations[count][0]
        });
    google.maps.event.addListener(marker, 'click', (function (marker, count) {
          return function () {
            infowindow.setContent(locations[count][0]);
            infowindow.open(map, marker);
          }
        })(marker, count));
      }
}
