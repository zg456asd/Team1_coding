library(sp) 

## row col values 
## 设置行列的值 
rowValues <- 1:5
colValues <- 1:14

## draw the polygons  
## 画出多边形格子
tepList<- c()
for(rowValue in rowValues){
  for(colValue in colValues){
    ## set the number of seat  
    ## 设置每一个多边形的数值
    seatNum <- (rowValue-1)*14+colValue
    ## draw island  
    ## 通过polygons函数来画出island
    Sr = Polygon(cbind(c(rowValue,rowValue,rowValue+1,rowValue+1,rowValue),c(colValue,colValue+1,colValue+1,colValue,colValue)))
    ## 给每一个island标上对应的id
    Srs = Polygons(list(Sr),seatNum)
    ## store 将对应好的polygons数据存储在向量中
    tepList<-c(tepList,Srs)
  }
}
SpP=SpatialPolygons(tepList,70:1)

## add atrr  
## 添加属性值
## import the data (seat.csv)   
## 导入seat.csv文件的数据
mydata1 <- read.table( file = "D:/seat.csv", header = TRUE, sep = "," )

## select the gpa over 3.3   
## 选定GPA的值
goodGap<-3.3

## 存储大于这个GPA值的座位信息  筛选掉使用缺省值的数据
great<-c()
for (i in 1:length(mydata1[,2])){
  if(mydata1[i,2]>=goodGap && !is.na(mydata1[i,3]) ){
    great<-c(great,mydata1[i,3] )
  }
}


## create a vector include 70 seats
df <- data.frame(gpa=1:70,row.names =1:70)
greatCount=0
## modify the value >3.3  ==1  <3.3  ==0
## 大于等于设定值的 值设为1
## 小于设定值的  值设为0
for(i in 1:length(df[,1])){
  if(rownames(df)[i] %in% great){
    df[i,1]<-1
    greatCount=greatCount+1
  }else
    df[i,1]<-0
}

## 创建空间多边形数据帧数据
## modify the row's name
SrDf = SpatialPolygonsDataFrame(SpP,df)
as(SrDf, "data.frame")
## 绘制网格
## draw
spplot(SrDf)


## select sample and 
## 选择样方  新建数据帧
df2<-data.frame(count=c(4,2,4,2,1,3))

## count the yangfang 
## 计算样方数
n <- length(df2[,"count"])

## av is the average of the yangfang
## 计算平均值
mean <- greatCount/ n 

## 计算方差
## variance
fcSum <- 0
for( i in 1:length(df2[,1])){
  fcSum <- fcSum +(df2[i,1]-mean)**2
}
variance <- fcSum/(n-1)

## VMR
VMR <- variance/mean
VMR
