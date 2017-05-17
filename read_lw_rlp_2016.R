library(sp)
library(maptools)
library(rgeos)
library(ggmap)
library(raster) #getData
library(gridExtra)
#library(xlsx)

source("functions.R")


adm0 <- raster::getData('GADM', country='DEU', level=0)
adm1 <- raster::getData('GADM', country='DEU', level=1)
adm2 <- raster::getData('GADM', country='DEU', level=2)
adm3 <- raster::getData('GADM', country='DEU', level=3)
adm4 <- raster::getData('GADM', country='DEU', level=4)


rlptemp<-adm3[which(adm3$NAME_1=="Rheinland-Pfalz"),]
rlpframe<-simlifySpFrame(rlptemp)

##################################
