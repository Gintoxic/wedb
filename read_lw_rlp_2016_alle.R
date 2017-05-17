


### Einlesen
url <- "http://www.wahlen.rlp.de/ltw/wahlen/2016/downloads/lwGesamt.txt"
imp<-read.table(url,sep=";", header = T, stringsAsFactors = F, encoding = "ANSI")

url2 <- "http://www.wahlen.rlp.de/ltw/wahlen/2016/downloads/lw000.txt"
imp2<-read.table(url2,sep=";", header = T, stringsAsFactors = F, encoding = "ANSI")

gebschl<-imp2$Gebietsschlüssel

str(imp)
ind<-which(imp$Gebietsschlüssel %in% gebschl)


Wahlkreis

impf<-imp[-ind,]

impf$Gebietsbezeichnung

wkind<-which(regexpr('Wahlkreis', impf$Gebietsbezeichnung)>-1)
length(wkind)

impf2<-impf[-wkind,]


impf2$Gebietsbezeichnung


vgind<-which(regexpr('VG', impf2$Gebietsbezeichnung)>-1)

impf3<-impf2[-vgind,]



impf3$Gebietsbezeichnung


krind<-which(regexpr('kreis', impf3$Gebietsbezeichnung)>-1)

impf4<-impf3[-krind,]

sum(impf4$Wahlberechtigte)

impf4$Gebietsbezeichnung




adm4 <- raster::getData('GADM', country='DEU', level=4)
adm4r<-adm4[which(adm4$NAME_1=="Rheinland-Pfalz"),]

source("functions.R")
adm4rf<-simlifySpFrame(adm4r)

tab<-table(impf4$Gebietsbezeichnung)>1
table(impf4$Gebietsbezeichnung)[which(tab)]

tab<-table(adm4rf$NAME_4)>1
table(adm4rf$NAME_4)[which(tab)]



res<-sqldf("select i.*, a.ID_1, a.NAME_1, a.ID_2, a.NAME_2, a.ID_3, a.NAME_3, a.ID_4, a.NAME_4 from impf4 i left join adm4rf a on i.Gebietsbezeichnung=a.NAME_4")
table(res$NAME_1)
dim(res)


sum(impf4$Wahlberechtigte)
str(impf4$Gebietsbezeichnung)



res<-sqldf("select a.*, i.Wahlberechtigte from adm4rf a left join impf4 i on a.NAME_4=i.Gebietsbezeichnung")
sum(res$Wahlberechtigte, na.rm = T)


