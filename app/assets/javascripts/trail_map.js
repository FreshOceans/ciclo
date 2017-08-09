// $(document).ready(function() {
$(document).on('turbolinks:load', function() {
    if (gon.shop_presence == true) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
            };
            console.log("pos:", pos);
            },
            function() {
                handleLocationError(true, infoWindow, map.getCenter());
            });
            function geolocationAjax() {
                console.log("== geolocationAjax ==");
                $.ajax({
                    url: '/find_bicycle_shops',
                    data: position.coords.latitude,
                    method: "GET",
                    dataType: "json",
                }).done (function(json_data){
                    console.log("== done ==");
                    shopResults(json_data);
                })
        } else {
           // Browser doesn't support Geolocation
           handleLocationError(false, infoWindow, map.getCenter());
        }
        function shopResults(json_data) {
            console.log("== shopResults ==");
        };
    } else if (gon.js_presence == true) {
        console.log("gon.js_presence:", gon.js_presence);
        if (gon.js_presence) {
            console.log("jQuery loaded/document ready");

            function trailAjaxQueue() {
                console.log("== trailAjaxQueue ==");
                $.ajax({
                    url: '/DC_Bike_Trails.geojson',
                    method: "GET",
                    dataType: "text",
                }).done (function(data) {
                    console.log("== done ==");
                    var dataParsed = $.parseJSON(data);
                    console.log("dataParsed:", dataParsed);
                    var foundTrail = extractTrail(dataParsed);
                    console.log("foundTrail:", foundTrail);
                    foundTrailData = foundTrail[0]
                    totalTrailData = foundTrail[1]
                    foundTrailData.geometry.coordinates = totalTrailData
                    var trailFeature = {"type":"FeatureCollection","features":[foundTrailData]}
                    console.log("trailFeature:", trailFeature);
                    var centerIndex = Math.floor(foundTrailData.geometry.coordinates.length / 2);
                    console.log("centerIndex:", centerIndex);
                    var centerIndexV2 = Math.floor(totalTrailData.length / 2);
                    console.log("centerIndexV2:", centerIndexV2);
                    var trailCenter = foundTrailData.geometry.coordinates[centerIndex];
                    console.log("trailCenter:", trailCenter);
                    generateMap(trailCenter, trailFeature);
                });
            };
            function extractTrail(data) {
                var foundTrailData = null;
                var totalTrailData = [];
                var latlngFlag = true;
                console.log("== extractTrail ==");
                console.log("data.features", data.features);
                console.log("gon.selected_trail =", gon.selected_trail);
                $.each(data.features, function(index, trail) {
                    console.log(trail.properties.NAME);
                    if (trail.properties.NAME == gon.selected_trail) {
                        console.log("++ Found Trail ++");
                        if (foundTrailData == null) {
                            foundTrailData = trail;
                            console.log("+ foundTrailData +", foundTrailData);
                        };
                        $.each(trail.geometry.coordinates, function(index, coordinates){
                            if (coordinates.length > 2) {
                                console.log("coordinates.length", coordinates.length);
                                var latlngFlag = false;
                                Array.prototype.push.apply(totalTrailData, coordinates )
                                console.log("+= totalTrailData =+", totalTrailData);
                            }
                        });
                        if (latlngFlag == true) {
                            Array.prototype.push.apply(totalTrailData, trail.geometry.coordinates )
                            console.log("+ totalTrailData +", totalTrailData);
                        }
                        latlngFlag = true;
                        // return false
                    };
                });
                return [foundTrailData, totalTrailData]
            };
            function generateMap(trailCenter, trailFeature) {
                var map_container = document.getElementById('map_container');
                latLng = { lat: trailCenter[1], lng: trailCenter[0]};
                console.log("== latLng", latLng);
                var zoom = 15;
                console.log("map_container:", map_container);
                console.log("$(map_container):", $(map_container));
                if (map_container) {
                    map_container.innerHTML = "";
                }
                map = new google.maps.Map(map_container, {
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
                console.log("map:", map);
                // var geocoder = new google.maps.Geocoder();
                // console.log("geocoder:", geocoder);
                // geocoder.geocode( { 'address': address}, function(results, status) {
                //     console.log("== geocode ==");
                //     console.log("results:", results);
                //     if (status == google.maps.GeocoderStatus.OK) {
                //       map.setCenter(results[0].geometry.location);
                //         var marker = new google.maps.Marker({
                //             map: map,
                //             position: results[0].geometry.location
                //         });
                //     }
                // });
                map.data.setStyle({
                    strokeColor: 'limegreen',
                    strokeWeight: 3,
                    strokeOpacity: 0.65
                });
                // map.data.loadGeoJson(foundTrail);
                map.data.addGeoJson(trailFeature);
            };
        };
        trailAjaxQueue();
    }

    // google.maps.event.addDomListener(window, "load", trailAjaxQueue());
}); //End of jQuery
