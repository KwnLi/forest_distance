library(sf)
library(tidyverse)
library(ggspatial)

fincom <- st_read("FINCOM_nf.geojson")
lu <- st_read("./DATA/landuse.geojson")

forest <- lu %>% filter(NewLU2 == "forest")

fincom.ext <- st_bbox(fincom)

forplot <- ggplot(fincom) + geom_sf(aes(color=nearest_forest)) +
  geom_sf(data=forest,fill="green") +
  ylim(c(15.16,15.18)) + xlim(c(-92.35,-92.325)) +
  theme_bw() +
  theme(legend.position = c(0.88,0.2))

ggsave("forest_distance_fig.png", height = 5, width = 6, units = "in", 
       dpi = 300, bg = "white")
