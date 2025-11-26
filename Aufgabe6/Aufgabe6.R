#install.packages("httr2")
library(httr2)

# Define the base URL and parameters
base <- "https://dataset.api.hub.geosphere.at/v1/timeseries/historical/inca-v1-1h-1km"
parameters <- "T2M,P0,VV"
start_date <- "2023-06-01T22:00"
end_date <- "2023-06-01T22:00"
latlon <- "47.0540581,12.9547162"  
output_format <- "geojson"

# Construct the full URL with query parameters using sprintf
full_url <- sprintf("%s?parameters=%s&start=%s&end=%s&lat_lon=%s&output_format=%s", base, parameters, start_date, end_date, latlon, output_format)

# Display the constructed URL
print(full_url)

# Create the request and perform it
req <- httr2::request(full_url)
resp <- httr2::req_perform(req)

# Check the status code of the response
httr2::resp_status(resp)

# View the content structure of the response in JSON
str(httr2::resp_body_json(resp))

# Using resp_body_json to get the JSON content of the response
response_content <- httr2::resp_body_json(resp)
response_df <- as.data.frame(response_content)

# rename columns and render data frame as html table
names(response_df) <- c("c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13","c14","c15","c16","c17")

print(sprintf("Am GeoSphere Sonnblick Observatorium (%s, %s) hatte es am %s um %s Uhr %s °C, der Wind wehte mit %s m/s nordwärts und der Luftdruck betrug %s Pa.",
              substr(response_df$c7,0,8),
              substr(response_df$c8,0,8),
              substr(response_df$c4,0,10),
              substr(response_df$c4,12,16),
              substr(response_df$c11,0,4),
              substr(response_df$c17,0,4),
              substr(response_df$c14,0,8)))

# Aufgabe4 
# Mit welcher zeitlichen und räumlichen Auflösung liegt der INCA-Datensatz vor?
# Zeitliche Auflösung beträgt 1h und die räumliche Auflösung 1km.
# Der Datensatz ist ein Grid.

# Welche zeitliche und räumliche Ausdehnung weist der Datensatz auf?
# Zeitliche Auflösung beginnt mit 2011-03-15T00:00+00:00 bis Stand heute 2025-11-26T20:00+00:00.
# Räumliche Auflösung [45.7722201058112, 8.09813374835229, 49.4781756846096, 17.7422704132337].
# Der erste Punkt befindet sich in Nordwest-Italien und der zweite Punkt im Osten von Tschechien.
# Ich vermute mal, dass sich zwischen den beiden Punkten das Grid spannt.