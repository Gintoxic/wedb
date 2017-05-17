library(sp)
library(maptools)
library(rgeos)
library(ggmap)
library(raster) #getData
library(gridExtra)
#library(xlsx)

source("functions.R")


#adm0 <- raster::getData('GADM', country='DEU', level=0)
#adm1 <- raster::getData('GADM', country='DEU', level=1)
adm2 <- raster::getData('GADM', country='DEU', level=2)
adm3 <- raster::getData('GADM', country='DEU', level=3)
#adm4 <- raster::getData('GADM', country='DEU', level=4)


rlptemp<-adm3[which(adm3$NAME_1=="Rheinland-Pfalz"),]
rlpframe<-simplifySpFrame(rlptemp)


### Einlesen
url <- "http://www.wahlen.rlp.de/ltw/wahlen/2016/downloads/lw000.txt"
imp<-read.table(url,sep=";", header = T, stringsAsFactors = F, encoding = "ANSI")

gebschl<-imp$Gebietsschlüssel

### Indizes bestimmen
lkind<-which(regexpr('kreis', imp$Gebietsbezeichnung)>-1)
vgind<-which(regexpr('VG', imp$Gebietsbezeichnung)>-1)
kfind<-which(regexpr('Kreisfreie', imp$Gebietsbezeichnung)>-1)
laind<-1

### Splitten
lk<-imp[lkind,]
vg<-imp[vgind,]
kf<-imp[kfind,]
la<-imp[laind,]


vg$Gebietsbezeichnung1<-gsub(", VG","",vg$Gebietsbezeichnung)
vg$Gebietsbezeichnung2<-gsub("-"," ",vg$Gebietsbezeichnung1)

library(sqldf)


rlpframe2<-rlpframe[which(rlpframe$NAME_3!="Bad Kreuznach"),]

vg2<-sqldf("select v.*, coalesce(r1.ID_3,r2.ID_3) as ID_3 from vg v 
left join rlpframe2 r1
on v.Gebietsbezeichnung1=r1.NAME_3
left join rlpframe2 r2
on v.Gebietsbezeichnung2=r2.NAME_3")


vg2[, c("ID_3", "Gebietsbezeichnung")]
vg2[which(is.na(vg2$ID_3)), c("Gebietsbezeichnung")]


 not_in<-which(!rlpframe$ID_3 %in% as.integer(names(table(vg2$ID_3))))
 rlpframe[not_in,c("ID_3", "NAME_3")]
 
 vg2$ID_3[13]<-3635L
 vg2$ID_3[14]<-3637L
 vg2$ID_3[49]<-3736L
 vg2$ID_3[57]<-3782L
 vg2$ID_3[150]<-3765L
 
 # Es konnten nicht zugewiesen werden: Bad Kreuznach, VG,  Maikammer, VG,   Rheinauen, VG
 
 ###################################################
 
 kf$Gebietsbezeichnung
 kf$Gebietsbezeichnung1<-gsub(", Kreisfreie Stadt","",kf$Gebietsbezeichnung)
 kf$Gebietsbezeichnung2<-NA
 
kf2<-sqldf("select k.*, r1.ID_1, r1.ID_2, r1.ID_3  from kf k 
left join rlpframe2 r1
            on k.Gebietsbezeichnung1=r1.NAME_3")
 
kf2[, c("ID_3", "Gebietsbezeichnung")]
 
 #vg$Gebietsbezeichnung2<-gsub("-"," ",vg$Gebietsbezeichnung1)
 
not_in<-which(!rlpframe$ID_3 %in% c(as.integer(names(table(vg2$ID_3))),as.integer(names(table(kf2$ID_3)))) )
rlpframe[not_in,c("ID_3", "NAME_3")]
 
dim(kf2)
dim(vg2)

vg_temp<-vg2
#dim(vb_kf)

save(list = "vg_temp", file="vg_temp.Rdata")

####################################################
rm(list="rlptemp2")
rlptemp2<-adm2[which(adm2$NAME_1=="Rheinland-Pfalz"),]
rlpframe2<-simlifySpFrame(rlptemp2)
rlpframe2$NAME_2
rlpframe2a<-rlpframe2[which(rlpframe2$NAME_2!="Kaiserslautern"),]

rlpframe2[which(rlpframe2$NAME_2=="Kaiserslautern"),]

lk$Gebietsbezeichnung
lk$Gebietsbezeichnung1<-gsub(", Landkreis","",lk$Gebietsbezeichnung)
lk$Gebietsbezeichnung2<-NA

table(lk$Gebietsbezeichnung1)
table(lk$Gebietsbezeichnung2)


lk2<-sqldf("select k.*, r.ID_1, r.ID_2, 0 as ID_3 from lk k 
left join rlpframe2a r
           on k.Gebietsbezeichnung1=r.NAME_2")
lk2$ID_1[2]<-11 
lk2$ID_2[2]<-298L #Altenkirchen
lk2$ID_1[19]<-11 
lk2$ID_2[19]<-310L #Kaiserslautern

#11 Rheinland-Pfalz  310 Kaiserslautern

lk2[, c("ID_2", "Gebietsbezeichnung1")]

dim(kf2)
dim(lk2)

names(kf2)==names(lk2)

lk_kf<-rbind(kf2,lk2)
dim(lk_kf)

#save(list = "lk_kf", file="lk_kf.Rdata")

#####################################################
sum(vb_kf$Wahlberechtigte)
#
 sum(lk2$Wahlberechtigte)
 sum(vg$Wahlberechtigte)
 sum(kf2$Wahlberechtigte)
 sum(lk2$Wahlberechtigte)
 
 ######### Checksumme #############
 sum(kf$Wahlberechtigte)+sum(lk$Wahlberechtigte)
 sum(lk_kf$Wahlberechtigte)
 sum(la$Wahlberechtigte)
 
