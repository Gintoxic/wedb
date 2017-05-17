adm1 <- raster::getData('GADM', country='DEU', level=1)


namen<-data.frame(name=adm1$NAME_1)

namen$num<-1:16


namen

namen$prz<-namen$rhf<-NA


  namen$prz[1]<-15.1
  #namen$prz[1]<-
  namen$prz[3]<-14.2
  namen$prz[4]<-12.2
  namen$prz[5]<-5.5
  namen$prz[6]<-6.1
  namen$prz[7]<-4.3
  namen$prz[8]<-20.8
  #namen$prz[9]<-
  namen$prz[10]<-7.4
  namen$prz[11]<-12.6
  namen$prz[12]<-6.2
  namen$prz[13]<-24.2
  namen$prz[14]<-9.7
  namen$prz[15]<-5.9
  namen$prz[16]<-10.6
  
  namen$rhf[1]<-"06_2016"

  namen$rhf[3]<-"04_2016"
  namen$rhf[4]<-"12_2014"
  namen$rhf[5]<-"09_2015"
  namen$rhf[6]<-"10_2015"
  namen$rhf[7]<-"14_2013"
  namen$rhf[8]<-"05_2016"

  namen$rhf[10]<-"01_2017"
  namen$rhf[11]<-"07_2016"
  namen$rhf[12]<-"03_2017"
  namen$rhf[13]<-"08_2016"
  namen$rhf[14]<-"13_2014"
  namen$rhf[15]<-"02_2017"
  namen$rhf[16]<-"11_2014"


  nameno<-namen[order(namen$rhf),] 
  
  namenoc<-nameno[1:14,]
  
  vec<-rev(namenoc$prz)
  names(vec)<-paste0(rev(namenoc$name)," (",rev(substr(namenoc$rhf,4,8)),")")
  
  par(mai=c(1.02,6,0.82,0.42))
  
  #col="#2876DD"
  mids<-barplot(vec, horiz = T,  
                xlim = c(0, max(namenoc$prz)*1.2), 
                las=1, cex.names = 2, col="#009DE0", 
                cex.axis = 2, axes = F)
  col<-"black"
  
  abline(v = 5,col = col,lty=3)
  abline(v = 10, col = col,lty=3)
  abline(v = 15, col = col,lty=3)
  abline(v = 20,  col = col,lty=3)
  
  
  ?abline
  
  lab<-paste0(prettyNum(rev(namenoc$prz),decimal.mark = ","), "%")
  
  text(x= rev(namenoc$prz), y=mids, labels = lab, cex = 3, pos=4)
  
  
  namen$jahr[]<-
  
    
    
  namen$jahr[10]<-2007
  namen$jahr[12]<-
  namen$jahr[13]<-
  namen$jahr[14]<-
  namen$jahr[15]<-
  namen$jahr[16]<-
    