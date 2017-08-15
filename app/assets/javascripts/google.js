// $(document).ready(function() {
$(document).on('turbolinks:load', function() {

    // =========== Shops Mapping via Google ==========
    $('#shops_link').click(function(event) {
        // console.log("You clicked ME");
        event.preventDefault();
        geoLocationInitiliaze();
    });
    function geoLocationInitiliaze() {
        // console.log("== geoLocationInitiliaze ==");
    // if (gon.shop_presence == true) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                // console.log("pos:", pos);
                // console.log("pos:", pos.lat);
                var url = '/find_bicycle_shops_ajax?lat=' + pos.lat + '&lng=' + pos.lng;
                function geolocationAjax(pos) {
                    // console.log("== geolocationAjax ==");
                    $.ajax({
                        url: url,
                        method: "GET",
                        dataType: "json",
                    }).done (function(jsonData){
                        // console.log("== done ==");
                        shopResults(jsonData);
                        displayPlaceMarkers(jsonData);
                    });
                };
                geolocationAjax(pos);
            },
            function() {
                handleLocationError(true, infoWindow, map.getCenter());
            });
        } else {
           // If browser doesn't support geoLocation
           handleLocationError(false, infoWindow, map.getCenter());
        }
    };
    function shopResults(jsonData) {
        // if (gon.shop_presence == true) {
            // console.log("gon.shop_presence:", gon.shop_presence);
            // if (gon.shop_presence) {
                // console.log("jsonData:", jsonData);
                var lat = jsonData["permitted_lat"];
                // console.log("lat", lat);
                var lng = jsonData["permitted_lng"];
                // console.log("lng", lng);
                var geoCoordinates = {lat, lng};
                // console.log("geoCoordinates:", geoCoordinates);
                var shopsMap = document.getElementById('shops_map');
                var zoom = 15;
                var latLng = geoCoordinates;
                // console.log("latLng:", latLng);
                // console.log("shopsMap:", shopsMap);
                if (shopsMap) {
                    shopsMap.innerHTML = "";
                };
                map = new google.maps.Map(shopsMap, {
                    center: latLng,
                    minZoom: 11,
                    maxZoom: 20,
                    disableDefaultUI: true,
                    disableDoubleClickZoom: true,
                    disableDragZoom: true,
                    draggable: true,
                    // styles: styleArray,     // styles for map tiles
                    mapTypeId: google.maps.MapTypeId.TERRAIN,
                    zoom: zoom
                });
                // console.log("map:", map);
        //     }
        // };
    };
    function displayPlaceMarkers(jsonData) {
        // console.log("== displayPlaceMarkers ==");
        var jsonData = jsonData["place_data_array"];
        // console.log("jsonData MARKERS:", jsonData);
        var nextPlace, nextName, nextLat, nextLon;
        // == Show Markers for Available Data
        var iconSize = 0.2;
        var icon = {
            path: "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
            fillColor: "red",
            strokeColor: "green",
            fillOpacity: 1,
            strokeWeight: 1,
            scale: iconSize
        };
        for (var i = 0; i < jsonData.length; i++) {
            nextPlace = jsonData[i];
            nextName = jsonData[i].name;
            nextLat = jsonData[i].geometry.location.lat;
            nextLon = jsonData[i].geometry.location.lng;
            var mapLatlng = new google.maps.LatLng(nextLat, nextLon);
            var placeMarker = new google.maps.Marker({
                map: map,
                icon: icon,
                title: nextName,
                draggable: false,
                optimized: false,
                position: mapLatlng,
                defaultColor: "red"
            });
            placeMarker.addListener('click', function(e) {
                // console.log("== placeMarker:click ==");
                var loc = placeMarker.getPosition();
                // console.log("loc.lat():", loc.lat());
                // console.log("loc.lng():", loc.lng());
                // make a div to display data
            });
        }
    };

    // =========== Trails Mapping via Google ==========
    if (gon.js_presence == true) {
        //  console.log("gon.js_presence:", gon.js_presence);
         if (gon.js_presence) {

             function trailAjaxQueue() {
                //  console.log("== trailAjaxQueue ==");
                 $.ajax({
                     url: '/DC_Bike_Trails.geojson',
                     method: "GET",
                     dataType: "text",
                 }).done (function(data) {
                    //  console.log("== done ==");
                     var dataParsed = $.parseJSON(data);
                    //  console.log("dataParsed:", dataParsed);
                     var foundTrail = extractTrail(dataParsed);
                     totalTrailData = foundTrail[1];
                     dataFeatures = foundTrail[0];
                    //  console.log("totalTrailData:", totalTrailData);
                    //  console.log("dataFeatures pre-Merge:", dataFeatures);
                     mergedGeoData = {
                         "type": "FeatureCollection",
                         "features": dataFeatures
                     };
                    //  console.log("mergedGeoData:", mergedGeoData);
                     var centerIndexV2 = Math.floor(totalTrailData.length / 2);
                    //  console.log("centerIndexV2:", centerIndexV2);
                     var trailCenter = totalTrailData[centerIndexV2];
                    //  console.log("trailCenter:", trailCenter);
                     generateMap(trailCenter, mergedGeoData);
                 });
             };
             function extractTrail(data) {
                //  console.log("\n ======= extractTrailData =======");

                 // == Initialize Paring Variables
                 var foundTrailData = null;
                 var collectionFeatures = [];
                //  console.log("collectionFeatures initial:", collectionFeatures);
                 var totalTrailData = [];
                 var latlngFlag = true;
                 var totalTrailPairs = 0;

                 // == Loop through all Trails
                 $.each(data.features, function(index, trail) {
                    //  console.log("name:", index, trail.properties.NAME);

                    //  console.log("gon.selected_trail:", gon.selected_trail);
                     // == Accumulate Found Trail Coordinates (parse segment data)
                     if (trail.properties.NAME == gon.selected_trail) {
                        //  console.log("+++++++ Found Trail +++++++");
                         collectionFeatures.push(trail);

                         // Initialize New Trail geojson object
                         if (foundTrailData == null) {
                             foundTrailData = trail;
                         };

                         // == Aggregate Coordinate Pairs for Segments
                         $.each(trail.geometry.coordinates, function(index, coordinates){
                             if (coordinates.length > 2) {
                                 totalTrailPairs = totalTrailPairs + coordinates.length;
                                 latlngFlag = false;
                                 Array.prototype.push.apply(totalTrailData, coordinates);
                             }
                         });
                         if (latlngFlag == true) {
                             totalTrailPairs = totalTrailPairs + trail.geometry.coordinates.length;
                            //  console.log("  totalTrailPairs AFTER:", totalTrailPairs);
                             Array.prototype.push.apply(totalTrailData, trail.geometry.coordinates )
                         } else {
                            //  console.log("  totalTrailPairs AFTER:", totalTrailPairs);
                         }
                         latlngFlag = true;
                     };
                 });
                //  console.log("collectionFeatures Post Push:", collectionFeatures);
                 return [collectionFeatures, totalTrailData]
             };

             // == Add Trail Feature to Map based of Trail Center
             function generateMap(trailCenter, mergedGeoData) {
                //  console.log("dataFeatures gMap ***", dataFeatures);
                 var map_container = document.getElementById('map_canvas');
                 latLng = { lat: trailCenter[1], lng: trailCenter[0]};
                //  console.log("== latLng", latLng);
                 var zoom = 15;
                //  console.log("map_container:", map_container);
                //  console.log("$(map_container):", $(map_container));
                 if (map_container) {
                     map_container.innerHTML = "";
                 }
                 map = new google.maps.Map(map_container, {
                     center: latLng,
                    //  minZoom: 11,
                    //  maxZoom: 20,
                     zoomControl: true,
                     disableDefaultUI: true,
                     disableDoubleClickZoom: true,
                     disableDragZoom: true,
                     draggable: true,
                     // styles: styleArray,     // styles for map tiles
                     mapTypeId: google.maps.MapTypeId.TERRAIN,
                    //  mapTypeId: google.maps.MapTypeId.ROADMAP,
                     zoom: zoom
                 });
                //  console.log("map:", map);
                 map.data.setStyle({
                     strokeColor: 'aqua',
                     strokeWeight: 3,
                     strokeOpacity: 0.65
                 });
                 map.data.addGeoJson(mergedGeoData);
                //  console.log("mergedGeoData MAP STAGE:", mergedGeoData);
             };
         };
         trailAjaxQueue();
     }
}); // End of jQuery
