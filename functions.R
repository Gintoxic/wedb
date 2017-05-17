simplifySpFrame<-function(rlp.temp)
{
  
  # rlp.frame<-data.frame(ID_0=rlp.temp$ID_0,NAME_0=rlp.temp$NAME_0,
  #            ID_1=rlp.temp$ID_0,NAME_1=rlp.temp$NAME_1,
  #            ID_2=rlp.temp$ID_0,NAME_2=rlp.temp$NAME_2,
  #            ID_3=rlp.temp$ID_0,NAME_3=rlp.temp$NAME_3, stringsAsFactors = F)
  # 
  #str(rlp.frame)
  
  rlp.frame<-rlp.temp@data
  
  rlp.frame$lon<-rlp.frame$lon<-NA
  for (i in 1:dim(rlp.temp)[1])
  {
    p1<-rlp.temp@polygons[[i]]
    rlp.frame$lon[i]<-p1@labpt[1]
    rlp.frame$lat[i]<-p1@labpt[2]
  } 
  
  return(rlp.frame)
  
}