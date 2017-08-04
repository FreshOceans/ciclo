$(document).ready(function() {
    if (gon.js_presence == true) {
        console.log("gon.js_presence:", gon.js_presence);
        if (gon.js_presence) {
            console.log("jQuery loaded/document ready");

            var mapContainer = document.getElementById('map-container');
            // var lat = 38.904706
            // var lng =-77.034715
            // $('#lat').val();
            latLng = { lat: 38.904706, lng: -77.034715};
            // $('#lng').val();
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

            function trailAjaxQueue() {
                console.log("== trailAjaxQueue ==");
                var trailData = null;

                $.ajax({
                    url: '/DC_Bike_Trails.geojson',
                    method: "GET",
                    dataType: "text",
                    // success: function(data) {processData(data);}
                }).done (function(data) {
                    console.log("== done ==");
                    var dataParsed = $.parseJSON(data)
                    extractTrail(dataParsed);
                });
                function extractTrail(data) {
                    console.log("== extractTrail ==");
                    console.log("data.features", data.features);
                    $.each(data.features, function(index, trail) {
                        if (trail.NAME == gon.selected_trail) {
                            console.log("++ Found Trail ++");
                        }
                    });
                }

            }


        }
    }

    trailAjaxQueue();
}); //End of jQuery
