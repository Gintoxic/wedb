load( file="lk_kf.Rdata")
load(file="vg_temp.Rdata")

source("functions.R")
#lkkf<-lk_kf[,c("Gebietsbezeichnung","ID_1","ID_2","ID_3")]
colnames(lk_kf)

adm2 <- raster::getData('GADM', country='DEU', level=2)
adm2rlp<-adm2[which(adm2$NAME_1=="Rheinland-Pfalz"),]
adm2rlps<-simplifySpFrame(adm2rlp)

lkkf<-sqldf("select lk.*, a.OBJECTID, a.ISO, a.NAME_1, a.NAME_2, a.lat, a.lon from lk_kf lk left join adm2rlps a on lk.ID_2=a.ID_2")


plot(adm2rlp)
str(adm2rlps)




##############################################################
colnames(vg_temp)

adm3 <- raster::getData('GADM', country='DEU', level=3)
adm3rlp<-adm3[which(adm3$NAME_1=="Rheinland-Pfalz"),]
adm3rlps<-simplifySpFrame(adm3rlp)
str(adm3rlps)

vg<-sqldf("select v.*, a.OBJECTID, a.ISO, a.NAME_1, a.NAME_2,a.NAME_3, a.lat, a.lon from vg_temp v left join adm3rlps a on v.ID_3=a.ID_3")

vg
str(vg)

vg$ID_3
plot(adm2rlp)
str(adm2rlps)


#save(list=c("lkkf", "vg"), file="lk_kf_vg.Rdata")




##############################################################


#save(list="lkkf", file="lkkf.Rdata")
colnames(lkkf)

### ids<-match(lkkf$ID_2,adm2rlps$ID_2)
### lkkf$ID_2
### adm2rlps$ID_2[ids]


ids<-match(adm2rlps$ID_2,lkkf$ID_2)

lkkf$ID_2[ids]
adm2rlps$ID_2
adm2rlps$val<-lkkf$Wahlberechtigte[ids]

text(adm2rlps$lon,adm2rlps$lat, adm2rlps$val)
text(adm2rlps$lon,adm2rlps$lat, adm2rlps$NAME_2, pos=3)




str(lkkf$ID_2)
str(adm2rlps$ID_2)

ad


ad <- merge(adm2rlps, lkkf, by.x = "ID_2", by.y = "ID_2")
merge(adm2rlps, lkkf, by = c("ID_1","ID_2"))



adm2rlp$col<-"white"
adm2rlp$col[id]<-"blue3"

