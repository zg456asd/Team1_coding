# R-language-Quadrat-analysis-AND-KDE
## Quadrat-analysis
### 样方分析步骤
研究区域中打上网格
确定每个网格中点的个数。
计算均值(Mean)、方差(Var)和方差均值比:VMR=Var/Mean
### VMR 结果判断
- 对于均匀分布，方差=0，因此VMR的期望值= 0；
- 对于随机分布，方差=均值，因此VMR的期望值= 1；
- 对于聚集分布，方差大于均值。因此VMR的期望值 >1 。

### 结果
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/Qa1.png)

## Kernel Density Estimation, KDE
### 分析步骤
- 处理数据
- 选取带宽
- 计算密度
### 结果
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/KDE.png)
