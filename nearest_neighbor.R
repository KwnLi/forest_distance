library(sf)

fincom <- st_read("FINCOM_nf.geojson")

distancematrix <- st_distance(fincom)

mindist <- apply(distancematrix,2, \(x) min(x[x>0]))

mindist.df <- bind_cols(name=fincom %>% pull(name), min.dist=mindist)

write.csv(mindist.df, "mindist.csv", row.names = FALSE)

min(mindist)

mean(mindist)
