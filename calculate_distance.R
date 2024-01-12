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
  geom_sf(data=forest,fill="green") +
  ylim(c(15.16,15.18)) + xlim(c(-92.35,-92.325)) + 
  ggtitle("EPIEXP (June)") +
  theme_bw()

ggplot(FINCOM) + geom_sf(aes(color=nearest_forest)) +
  geom_sf(data=forest,fill="green") +
  ylim(c(15.16,15.18)) + xlim(c(-92.35,-92.325)) + 
  ggtitle("FINCOM (July)")+
  theme_bw()

st_write(EPIEXP %>% select(name,time,ele,nearest_forest), "EPIEXP_nf.geojson")
st_write(FINCOM %>% select(name,time,ele,nearest_forest), "FINCOM_nf.geojson")
st_write(forest, "forest_poly.geojson")

write.csv(EPIEXP %>% select(name,time,ele,nearest_forest) %>% st_drop_geometry(), "EPIEXP_nf.csv")
write.csv(FINCOM %>% select(name,time,ele,nearest_forest) %>% st_drop_geometry(), "FINCOM_nf.csv")
