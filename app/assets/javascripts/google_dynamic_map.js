$(document).ready(function() {
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
                    console.log("+ dataParsed +", dataParsed);
                    var foundTrail = extractTrail(dataParsed);
                    console.log("foundTrail:", foundTrail);
                    var centerIndex = Math.floor(foundTrail.geometry.coordinates.length / 2);
                    console.log("== centerIndex ==", centerIndex);
                    var trailCenter = foundTrail.geometry.coordinates[centerIndex];
                    console.log("trailCenter", trailCenter);
                    generateMap(trailCenter);
                });
            };
            function extractTrail(data) {
                var foundTrailData = null;
                console.log("== extractTrail ==");
                console.log("data.features", data.features);
                console.log("gon.selected_trail =", gon.selected_trail);
                $.each(data.features, function(index, trail) {
                    console.log(trail.properties.NAME);
                    if (trail.properties.NAME == gon.selected_trail) {
                        console.log("++ Found Trail ++");
                        foundTrailData = trail;
                        console.log("+ foundTrailData +", foundTrailData);
                        return false
                    };
                });
                return foundTrailData
            };
            function generateMap(trailCenter) {
                var mapContainer = document.getElementById('map-container');
                latLng = { lat: trailCenter[1], lng: trailCenter[0]};
                console.log("== latLng", latLng);
                var zoom = 15;
                console.log("mapContainer:", mapContainer);
                console.log("$(mapContainer):", $(mapContainer));
                if (mapContainer) {
                    mapContainer.innerHTML = "";
                }
                map = new google.maps.Map(mapContainer, {
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
            };
        };
    }

    trailAjaxQueue();
}); //End of jQuery
