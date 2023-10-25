library(sf)
library(tidyverse)

EPIEXP <- st_read("./DATA/EPIEXP.geojson")
FINCOM <- st_read("./DATA/FINCOM.geojson")
lu <- st_read("./DATA/landuse.geojson")

forest <- lu %>% filter(NewLU2 == "forest")

# calculate distance to each forest polygon
# creates a matrix-like object with a row for each point
# distance to each forest polygon is represented by columns
# convert this to a dataframe and find the nearest distance put it in a new column

fdist_epiexp <- st_distance(EPIEXP, forest) %>% as.data.frame() %>%
  rowwise() %>%
  mutate(nearest = min(across()))
fdist_fincom <- st_distance(FINCOM, forest) %>% as.data.frame()%>%
  rowwise() %>%
  mutate(nearest = min(across()))

# find the nearest distance and add it to the points as a column
EPIEXP$nearest_forest <- as.numeric(fdist_epiexp$nearest)
FINCOM$nearest_forest <- as.numeric(fdist_fincom$nearest)

ggplot(EPIEXP) + geom_sf(aes(color=nearest_forest)) +
  geom_sf(data=FINCOM, mapping = aes(color = nearest_forest)) + 
  geom_sf(data=forest,fill="green") +
  ylim(c(15.16,15.18)) + xlim(c(-92.35,-92.325)) + 
  theme_bw()
