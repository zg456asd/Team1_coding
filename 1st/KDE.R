library(sp) 
library(spatstat)
library(maptools)

## row col values
## 设置行列的值
rowValues = 1:5
colValues<- 1:14

## draw the polygons
## 创建多边形对象
tepList<- c()
for(rowValue in rowValues){
  for(colValue in colValues){
    ## 设置每一个多边形的数值
    seatNum <- (rowValue-1)*14+colValue
    ## draw island
    ## 通过polygons函数来画出island
    Sr = Polygon(cbind(c(rowValue,rowValue,rowValue+1,rowValue+1,rowValue),c(colValue,colValue+1,colValue+1,colValue,colValue)))
    ## 给每一个island标上对应的id
    Srs = Polygons(list(Sr),seatNum)
    ## cun
    tepList<-c(tepList,Srs)
  }
}
SpP=SpatialPolygons(tepList,70:1)

## from SpatialPolygons  to  “owin”  object (window)
## 将SpatialPolygons转换成owin对象
cityOwin <- as.owin(SpP)
class(cityOwin)

## add atrr
## 添加属性值
## import the data (seat.csv)
## 导入seat.csv文件的数据
mydata1 <- read.table( file = "D:/seat.csv", header = TRUE, sep = "," )

## select the gpa over 3.3
## 选定GPA的值
goodGap<-3.3
great<-c()
for (i in 1:length(mydata1[,2])){
  if(mydata1[i,2]>=goodGap  && !is.na(mydata1[i,3]) ){
    great<-c(great,mydata1[i,3])
  }
}
## select what we need store in a vector


## create a vector include 70 seats
df <- data.frame(gpa=1:70,row.names =1:70 )

## modify the row's name

## 创建空间多边形数据帧数据
SrDf = SpatialPolygonsDataFrame(SpP,df)
as(SrDf, "data.frame")

## SpatialPointsDataFrame to coordinates 
## 把SpatialPointsDataFrame转换成coordinates类型
pts <- coordinates(SrDf)
## 选出好的部分的坐标数据
test<-c()
for( i in great){
  test<-c(test,pts[i,])
}
## 把左边数据放入矩阵
ptss<-matrix(data = test, nrow = length(test)/2, ncol = 2,byrow=T)

## create a 'ppp' object
## 创建PPP  点模型对象
p <- ppp(ptss[,1], ptss[,2], window=cityOwin)
plot(p)

## calculate the density
## bw * adjust
## 使用密度函数， 并设置带宽
ds <- density(p, bw ="nrd0",adjust = 1)
## draw 
## 画出最终的核密度图
plot(ds, main='Seat density')
