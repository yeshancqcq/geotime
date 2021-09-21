library(readr)
library(RCurl)
library(jsonlite)
library(geojsonio)

points <- read_csv("C:/Users/yesha/Downloads/yh/points.csv")

x = "https://dev.macrostrat.org/api/geologic_units/map?lat=35&lng=110"
js = fromJSON(x)


length(js$success$data)

lat = "5"
lon= "3"

paste("https://dev.macrostrat.org/api/geologic_units/map?lat=",lat,"&lng=",lon, sep = "", collapse = NULL)


for(i in 5964:nrow(points)){
  lat = toString(points$lat[i])
  lon = toString(points$lon[i])
  x = paste("https://dev.macrostrat.org/api/geologic_units/map?lat=",lat,"&lng=",lon, sep = "", collapse = NULL)
  js = fromJSON(x)
  if(length(js$success$data)==0){
    points$age_max[i]=-1
    points$age_min[i]=-1
  } else {
    points$age_max[i]=js$success$data$b_age
    points$age_min[i]=js$success$data$t_age
  }
  cat("processing",i,"\n")
}

br <- geojson_read("https://raw.githubusercontent.com/yeshancqcq/geotime/master/bedrock.geojson",  what = "sp")
br_s <- subset(br, age_max >= 200 )
br_ss <- subset(br_s, age_min <= 144 )

library(sp)
par(mar=c(0,0,0,0))
sp::plot(br, col="grey70",border=NA)
sp::plot(br_ss, col="salmon", border=NA, add = T)



bedrock <- function(x, y=-1, range="partial"){
  if(x < 0){
    cat("Input data wrong. The value should be between 0 and 4600.")
  }
  else if(x > y){
    cat("Input data wrong. The second value should be either blank or bigger than the first value.")
  }
  else if(!(range %in% c("partial","entire"))){
    cat("Input data wrong. Range should be either partial or entire.")
  }
  else if(x <= y){
    br <- geojson_read("https://raw.githubusercontent.com/yeshancqcq/geotime/master/bedrock.geojson",  what = "sp")
    br_s <- subset(br, age_max >= x)
    br_ss <- subset(br_s, age_min <= x )
    
    if(range == "partial"){
      br_s <- subset(br, age_max >= x)
      br_ss <- subset(br_s, age_min <= y )
    } else {
      br_s <- subset(br, age_max >= y)
      br_ss <- subset(br_s, age_min <= x )
    }
    
    par(mar=c(0,0,0,0))
    sp::plot(br, col="grey70",border=NA)
    sp::plot(br_ss, col="#d9d4b4", border=NA, add = T)
  } 
}
bedrock(4000,5000,range="entire")
