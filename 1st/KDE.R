library(sp) 
library(spatstat)
library(maptools)
## row col values
rowValues = 1:5
colValues<- 1:14

## draw the polygons
tepList<- c()
for(rowValue in rowValues){
  for(colValue in colValues){
    seatNum <- (rowValue-1)*14+colValue
    ## paste str and number
    seatNum = paste("Sr",seatNum,sep="") 
    ## draw island
    Sr = Polygon(cbind(c(rowValue,rowValue,rowValue+1,rowValue+1,rowValue),c(colValue,colValue+1,colValue+1,colValue,colValue)))
    Srs = Polygons(list(Sr),seatNum)
    ## cun
    tepList<-c(tepList,Srs)
  }
}
SpP=SpatialPolygons(tepList,70:1)

# from SpatialPolygons  to  ¡°owin¡±  object (window)
cityOwin <- as.owin(SpP)
class(cityOwin)

## add atrr
## import the data (seat.csv)
mydata1 <- read.table( file = "D:/seat.csv", header = TRUE, sep = "," )

## select the gpa over 3.3
goodGap<-3.3
great<-c()
for (i in 1:length(mydata1[,2])){
  if(mydata1[i,2]>=goodGap  && !is.na(mydata1[i,3]) ){
    great<-c(great,paste("Sr",mydata1[i,3],sep="") )
  }
}
## select what we need store in a vector
name<-c()
for(value in 1:70){
  seatNum = paste("Sr",value,sep="")
  name<-c(name,seatNum)
}

## create a vector include 70 seats
df <- data.frame(gpa=1:70,row.names =name )

## modify the row's name
SrDf = SpatialPolygonsDataFrame(SpP,df)
as(SrDf, "data.frame")

# SpatialPointsDataFrame to coordinates 
pts <- coordinates(SrDf)

test<-c()
for( i in great){
  test<-c(test,pts[i,])
}

rowM<-c()
colM<-c()
for( i in 1:length(test)){
  if(i%%2==1){
    rowM<-c(rowM,test[i])
  }else{
    colM<-c(colM,test[i])
  }
}

ptss<-matrix(data = test, nrow = length(test)/2, ncol = 2,byrow=T)

#vreate a 'ppp' object
p <- ppp(ptss[,1], ptss[,2], window=cityOwin)
plot(p)

# calculate the density
# bw * adjust
ds <- density(p, bw ="nrd0",adjust = 1)
# draw 
plot(ds, main='Seat density')
