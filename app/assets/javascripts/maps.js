function initMap(locations) {
    var myCoords = new google.maps.LatLng(locations[0][1], locations[0][2]);
    var mapOptions = {
    center: myCoords,
    zoom: 10    
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




// this works!
// function initMap() {
//     var myCoords = new google.maps.LatLng(34.052235, -118.243683);
//     var myCoords2 = new google.maps.LatLng(34.024212,-118.496475)
//     var mapOptions = {
//     center: myCoords2,
//     zoom: 14
//     };
//     var map = new google.maps.Map(document.getElementById('map'), mapOptions);
//     var marker = new google.maps.Marker({
//         position: myCoords,
//         map: map
//     })
//     var marker = new google.maps.Marker({
//         position: myCoords2,
//         map: map
//     })


// }








// original
// var locations = [
//     ['Los Angeles', 34.052235, -118.243683],
//     ['Santa Monica', 34.024212, -118.496475],
//     ['Redondo Beach', 33.849182, -118.388405],
//     ['Newport Beach', 33.628342, -117.927933],
//     ['Long Beach', 33.770050, -118.193739]
//   ];
// ...
// var infowindow =  new google.maps.InfoWindow({});
// var marker, count;
// for (count = 0; count < locations.length; count++) {
//     marker = new google.maps.Marker({
//       position: new google.maps.LatLng(locations[count][1], locations[count][2]),
//       map: map,
//       title: locations[count][0]
//     });
// google.maps.event.addListener(marker, 'click', (function (marker, count) {
//       return function () {
//         infowindow.setContent(locations[count][0]);
//         infowindow.open(map, marker);
//       }
//     })(marker, count));
//   }