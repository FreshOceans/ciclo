$(document).on('turbolinks:load', function() {
    if (gon.wu_presence == true) {
        // console.log("gon.wu_presence:", gon.wu_presence);
        if (gon.wu_presence) {
            // console.log("jQuery loaded/document ready");

            function wundergroundAjax() {
                // console.log("== wundergroundAjax ==");
                var wu_url = "/wu_url";
                // console.log("wu_url:", wu_url);
                $.ajax({
                    url: wu_url,
                    method: "GET",
                    dataType: "json",
                }).done (function(json_data){
                    // console.log("== done ==");
                    // console.log("json_data:", json_data);
                    displayResults(json_data);
                });
            };
            function displayResults(json_data) {
                // console.log("== displayResults ==");
                var hourly = json_data.hourly_data;
                html_str = "";
                counter = 0;
                $.each(hourly.hourly_forecast, function(index, hour) {
                    // console.log("hour.FCTTIME.civil", hour.FCTTIME.civil);
                    counter++;
                    time = hour.FCTTIME.civil;
                    temp = hour.temp.english;
                    condition = hour.condition;
                    condition_icon = hour.icon_url;
                    feels_like = hour.feelslike.english;
                    if (counter < 4) {
                        html_str += "<div id='time'>" + time + "</div>";
                        html_str += "<div id='temp'>" + 'Currently:  ' + temp + "&#8457" + "</div>";
                        html_str += "<div id='condition'>" + condition + "</div>";
                        html_str += "<div id='condition_icon'>" + "<img src=" + condition_icon + ">" + "</div>";
                        html_str += "<div id='feels_like'>" + 'Feels like: ' + feels_like + "</div>";
                    };
                });
                // append to hourly_forecast
                $("#hourly_forecast").append(html_str);
            };
        };
        wundergroundAjax();
    };
}); //End of jQuery
