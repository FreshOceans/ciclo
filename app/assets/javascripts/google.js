// $(document).ready(function() {
$(document).on('turbolinks:load', function() {

    // =========== Shops Mapping via Google ==========
    $('#shops_link').click(function(event) {
        console.log("You clicked ME");
        event.preventDefault();
        geoLocationInitiliaze();
    });
    function geoLocationInitiliaze() {
        console.log("== geoLocationInitiliaze ==");
    // if (gon.shop_presence == true) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                console.log("pos:", pos);
                console.log("pos:", pos.lat);
                var url = '/find_bicycle_shops_ajax?lat=' + pos.lat + '&lng=' + pos.lng
                console.log("url:", url);
                function geolocationLink(url) {
                    console.log("== geolocationLink ==");
                    window.location.href = url;
                };
                geolocationLink(url);
            },
            function() {
                handleLocationError(true, infoWindow, map.getCenter());
            });
        } else {
           // If browser doesn't support geoLocation
           handleLocationError(false, infoWindow, map.getCenter());
        }
    };
    if (gon.shop_presence == true) {
        console.log("gon.shop_presence:", gon.shop_presence);
        if (gon.shop_presence) {
            var shops_map = document.getElementById('#shops_map');
            // var lat = $('#lat').val();
            // var lng = $('#lng').val();
            var zoom = 15;
            var latLon = getLatLon();
            console.log("shops_map:", shops_map);
            console.log("$(shops_map):", $(shops_map));
            if (mapContainer) {
                mapContainer.innerHTML = "";
            }

            // == show markers for available data
            var iconSize = 0.2;
            var icon = {
                path: "M-20,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0",
                fillColor: "green",
                strokeColor: "blue",
                fillOpacity: 1,
                strokeWeight: 1,
                scale: iconSize
            }

            map = new google.maps.Map(mapContainer, {
                center: latLon,
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

            var geocoder = new google.maps.Geocoder();
            console.log("geocoder:", geocoder);
            geocoder.geocode( { 'address': address}, function(results, status) {
                console.log("== geocode ==");
                console.log("results:", results);
                if (status == google.maps.GeocoderStatus.OK) {
                  map.setCenter(results[0].geometry.location);
                    var marker = new google.maps.Marker({
                        map: map,
                        position: results[0].geometry.location
                    });
                }
            });

            // ======= get selected data =======
            var map_ = "/find_bicycle_shops_ajax";
            $.ajax({
                url: url,
                // data:,
                method: "GET",
                dataType: "json"
            }).done(function(jsonData) {
                console.log("*** ajax success ***");
                jsonArray = jsonData.place_data_array;
                console.dir(jsonArray)
                displayPlaceMarkers(jsonArray);
            }).fail(function(){
                console.log("*** ajax fail ***");
            }).error(function() {
                console.log("*** ajax error ***");
            });
            function displayPlaceMarkers(jsonData) {
                console.log("== displayPlaceMarkers ==");
                var nextPlace, nextName, nextLat, nextLon;
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
                        console.log("== placeMarker:click ==");
                        var loc = placeMarker.getPosition();
                        console.log("loc.lat():", loc.lat());
                        console.log("loc.lng():", loc.lng());
                    });
                }
            }

            function getLatLon(neighborhood) {
                console.log("== getLatLon ==");
                switch (neighborhood) {
                    case "Downtown":
                        loc = { lat: 38.904706, lng: -77.034715};
                        break;
                    case "U-Street Corridor":
                        loc = { lat: 38.916965, lng: -77.029642};
                        break;
                    case "Bloomingdale":
                        loc = { lat: 38.915730, lng: -77.012186};
                        break;
                    case "Columbia Heights":
                        loc = { lat: 38.930178, lng: -77.032753};
                        break;
                    case "Petworth":
                        loc = { lat: 38.937189, lng: -77.021885};
                        break;
                    case "11th St":
                        loc = { lat: 38.931806, lng: -77.028258};
                        break;
                    default:
                        loc = { lat: 38.904706, lng: -77.034715};
                }
                return loc;
            }
        }
    };


    // =========== Trails Mapping via Google ==========
    if (gon.js_presence == true) {
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
