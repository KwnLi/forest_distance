#####Importing GPX files in R

###Load required packages
library(Rcpp)
library(sf)
library(ggplot2)
library(tidyverse)

###Preview the file
st_layers("./DATA/GPS POINTS/Waypoints_03-MAR-22.gpx")

###Read the file and select desired layer
FINCOM<-list()
EPIEXP<-st_read("./DATA/GPS POINTS/Waypoints_21-JUN-22.gpx", layer="waypoints")
FINCOM[[1]]<-st_read("./DATA/GPS POINTS/Waypoints_04-JUL-22.gpx", layer="waypoints")
FINCOM[[2]]<-st_read("./DATA/GPS POINTS/Waypoints_05-JUL-22.gpx", layer="waypoints")
FINCOM[[3]]<-st_read("./DATA/GPS POINTS/Waypoints_06-JUL-22.gpx", layer="waypoints")
FINCOM<-bind_rows(FINCOM[1:3])

###Plot the coordinates
ggplot(EPIEXP)+
  geom_sf()

ggplot(FINCOM)+
  geom_sf()

st_write(EPIEXP, "EPIEXP.geojson")
st_write(FINCOM, "FINCOM.geojson")

###Extra code
st_distance()
st_points(point, polygon)

