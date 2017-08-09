// $(document).ready(function() {
//     if (gon.js_presence == true) {
//         console.log("gon.js_presence:", gon.js_presence);
//         if (gon.js_presence) {
//             console.log("jQuery loaded/document ready");
//
//             var mapContainer = document.getElementById('map-container');
//             var neighborhood = $('#neighborhood').val();
//             var lat = $('#lat').val();
//             var lng = $('#lng').val();
//             var zoom = 15;
//             var latLon = getLatLon(neighborhood);
//             console.log("address:", address);
//             console.log("mapContainer:", mapContainer);
//             console.log("$(mapContainer):", $(mapContainer));
//             if (mapContainer) {
//                 mapContainer.innerHTML = "";
//             }
//
//             // == show markers for available data
//             var iconSize = 0.2;
//             var icon = {
//                 path: "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
//                 fillColor: "red",
//                 strokeColor: "green",
//                 fillOpacity: 1,
//                 strokeWeight: 1,
//                 scale: iconSize
//             }
//
//             map = new google.maps.Map(mapContainer, {
//                 center: latLon,
//                 minZoom: 11,
//                 maxZoom: 20,
//                 disableDefaultUI: true,
//                 disableDoubleClickZoom: true,
//                 disableDragZoom: true,
//                 draggable: true,
//                 // styles: styleArray,     // styles for map tiles
//                 mapTypeId: google.maps.MapTypeId.TERRAIN,
//                 zoom: zoom
//             });
//             console.log("map:", map);
//
//             var geocoder = new google.maps.Geocoder();
//             console.log("geocoder:", geocoder);
//             // var address =  "1600 Pensylvannia Ave NW Washington DC"
//             // var address =  "734 Quebec Place NW Washington DC 20010"
//             // var address =  "3300 Georgia Ave NW Washington DC"
//             geocoder.geocode( { 'address': address}, function(results, status) {
//                 console.log("== geocode ==");
//                 console.log("results:", results);
//                 if (status == google.maps.GeocoderStatus.OK) {
//                   map.setCenter(results[0].geometry.location);
//                     var marker = new google.maps.Marker({
//                         map: map,
//                         position: results[0].geometry.location
//                     });
//                 }
//             });
//
//             // ======= get selected data =======
//             var url = "/local_bars_json";
//
//             $.ajax({
//                 url: url,
//                 data: { neighborhood: neighborhood },
//                 method: "GET",
//                 dataType: "json"
//             }).done(function(jsonData) {
//                 console.log("*** ajax success ***");
//                 jsonArray = jsonData.place_data_array;
//                 console.dir(jsonArray)
//                 displayPlaceMarkers(jsonArray);
//             }).fail(function(){
//                 console.log("*** ajax fail ***");
//             }).error(function() {
//                 console.log("*** ajax error ***");
//             });
//
//             function displayPlaceMarkers(jsonData) {
//                 console.log("== displayPlaceMarkers ==");
//                 var nextPlace, nextName, nextLat, nextLon;
//                 for (var i = 0; i < jsonData.length; i++) {
//                     nextPlace = jsonData[i];
//                     nextName = jsonData[i].name;
//                     nextLat = jsonData[i].geometry.location.lat;
//                     nextLon = jsonData[i].geometry.location.lng;
//                     var mapLatlng = new google.maps.LatLng(nextLat, nextLon);
//
//                     var placeMarker = new google.maps.Marker({
//                         map: map,
//                         icon: icon,
//                         title: nextName,
//                         draggable: false,
//                         optimized: false,
//                         position: mapLatlng,
//                         defaultColor: "red"
//                     });
//
//                     placeMarker.addListener('click', function(e) {
//                         console.log("== placeMarker:click ==");
//                         var loc = placeMarker.getPosition();
//                         console.log("loc.lat():", loc.lat());
//                         console.log("loc.lng():", loc.lng());
//                     });
//                 }
//             }
//
//             function getLatLon(neighborhood) {
//                 console.log("== getLatLon ==");
//                 switch (neighborhood) {
//                     case "Downtown":
//                         loc = { lat: 38.904706, lng: -77.034715};
//                         break;
//                     case "U-Street Corridor":
//                         loc = { lat: 38.916965, lng: -77.029642};
//                         break;
//                     case "Bloomingdale":
//                         loc = { lat: 38.915730, lng: -77.012186};
//                         break;
//                     case "Columbia Heights":
//                         loc = { lat: 38.930178, lng: -77.032753};
//                         break;
//                     case "Petworth":
//                         loc = { lat: 38.937189, lng: -77.021885};
//                         break;
//                     case "11th St":
//                         loc = { lat: 38.931806, lng: -77.028258};
//                         break;
//                     default:
//                         loc = { lat: 38.904706, lng: -77.034715};
//                 }
//                 return loc;
//             }
//         }
//     }
// }); //End of jQuery
//
// // var styleArray = [
// //     { featureType: "all",
// //         stylers: [
// //             { saturation: -100 },
// //             { lightness: 40 }
// //         ]
// //     },
// //     { featureType: "road",
// //         elementType: "geometry",
// //         stylers: [
// //             { hue: "#00ffee" },
// //             { saturation: -50 }
// //         ]
// //     },
// //     { featureType: "road",
// //         elementType: 'labels',
// //         stylers: [
// //             { saturation: -100 },
// //             { invert_lightness: false },
// //             { visibility: "off" }
// //         ]
// //     },
// //     { featureType: "poi",
// //         elementType: "labels",
// //         stylers: [
// //             { visibility: "off" }
// //         ]
// //     }
// // ];
