library(sp) 

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
    ## store
    tepList<-c(tepList,Srs)
  }
}
SpP=SpatialPolygons(tepList,70:1)

## add atrr
## import the data (seat.csv)
mydata1 <- read.table( file = "D:/seat.csv", header = TRUE, sep = "," )

## select the gpa over 3.3
goodGap<-3.3

great<-c()
for (i in 1:length(mydata1[,2])){
  if(mydata1[i,2]>=goodGap && !is.na(mydata1[i,3]) ){
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

greatCount=0
## modify the value >3.3  ==1  <3.3  ==0
for(i in 1:length(df[,1])){
  if(rownames(df)[i] %in% great){
    df[i,1]<-1
    greatCount=greatCount+1
  }else
    df[i,1]<-0
}

## modify the row's name
SrDf = SpatialPolygonsDataFrame(SpP,df)
as(SrDf, "data.frame")

## draw
spplot(SrDf)


## select sample and 

df2<-data.frame(row.names <- c(1,2,3,4,5,6),count <- c(4,2,4,2,1,3))
## count the yangfang 
n <- length(df2[,1])
## av is the average of the yangfang
mean <- greatCount/ n 
##
fcSum <- 0
for( i in 1:length(df2[,1])){
  fcSum <- fcSum+(df2[1,1]-mean)**2
}
## variance
variance <- fcSum/(n-1)
## VMR
VMR <- variance/mean
VMR
