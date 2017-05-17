load(url("http://dl.dropbox.com/u/61803503/nycounty.RData"))
head(ny); head(key)  #view the data set from my drop box

if (!require("pacman")) install.packages("pacman")
p_load(ggplot2, ggtree, dplyr, tidyr, sp, maps, pipeR, grid, XML, gtable)

getLabelPoint <- function(county) {Polygon(county[c('long', 'lat')])@labpt}

df <- map_data('county', 'new york')                 # NY region county data
centroids <- by(df, df$subregion, getLabelPoint)     # Returns list
centroids <- do.call("rbind.data.frame", centroids)  # Convert to Data Frame
names(centroids) <- c('long', 'lat')                 # Appropriate Header

pops <-  "http://data.newsday.com/long-island/data/census/county-population-estimates-2012/" %>%
  readHTMLTable(which=1) %>%
  tbl_df() %>%
  select(1:2) %>%
  setNames(c("region", "population")) %>%
  mutate(
    population = {as.numeric(gsub("\\D", "", population))},
    region = tolower(gsub("\\s+[Cc]ounty|\\.", "", region)),
    #weight = ((1 - (1/(1 + exp(population/sum(population)))))/11) 
    weight = exp(population/sum(population)),
    weight = sqrt(weight/sum(weight))/3
  )


race_data_long <- add_rownames(centroids, "region") %>>%
  left_join({distinct(select(ny, region:other))}) %>>%
  left_join(pops) %>>%
  (~ race_data) %>>%
  gather(race, prop, white:other) %>%
  split(., .$region)

pies <- setNames(lapply(1:length(race_data_long), function(i){
  ggplot(race_data_long[[i]], aes(x=1, prop, fill=race)) +
    geom_bar(stat="identity", width=1) + 
    coord_polar(theta="y") + 
    theme_tree() + 
    xlab(NULL) + 
    ylab(NULL) + 
    theme_transparent() +
    theme(plot.margin=unit(c(0,0,0,0),"mm"))
}), names(race_data_long))


e1 <- ggplot(race_data_long[[1]], aes(x=1, prop, fill=race)) +
  geom_bar(stat="identity", width=1) + 
  coord_polar(theta="y") 

leg1 <- gtable_filter(ggplot_gtable(ggplot_build(e1)), "guide-box") 


p <- ggplot(ny, aes(long, lat, group=group)) +  
  geom_polygon(colour='black', fill=NA) +
  theme_bw() +
  annotation_custom(grob = leg1, xmin = -77.5, xmax = -78.5, ymin = 44, ymax = 45) 



n <- length(pies)

for (i in 1:n) {
  
  nms <- names(pies)[i]
  dat <- race_data[which(race_data$region == nms)[1], ]
  p <- subview(p, pies[[i]], x=unlist(dat[["long"]])[1], y=unlist(dat[["lat"]])[1], dat[["weight"]], dat[["weight"]])
  
}

print(p)