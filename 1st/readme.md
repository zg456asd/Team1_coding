# R-language-Quadrat-analysis-AND-KDE
## Quadrat-analysis
### 样方分析步骤
- 研究区域中打上网格
- 确定每个网格中点的个数
- 计算均值(Mean)、方差(Var)和方差均值比:VMR=Var/Mean

### 代码解释
#### 1. 建立网格
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/code1.png)
####    网格效果
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/1.png)
#### 2. 添加属性
选择GPA大于3.3的数据，将大于设定的属性值为1，低于设定的属性值为0
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/code2.png)
####    网格效果
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/Qa1.png)
#### 3. 计算结果 
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/code3.png)

- 总样方数： n = 6
- 平均数：   mean = 2.666667
- 方差：     variance = 1.466667
- VMR：      VMR = 0.55

### VMR 结果判断依据
- 对于均匀分布，方差等于0，因此VMR的期望值= 0；
- 对于随机分布，方差等于均值，因此VMR的期望值= 1；
- 对于聚集分布，方差大于均值。因此VMR的期望值 >1 。

### 结论
通过计算，方差为1.47，平均值为2.67，方差于平均值的比值为0.55，介于0-1之间，但又偏向于1，初步设定为随机分布。

## Kernel Density Estimation, KDE
### 分析步骤
- 处理数据
- 选取带宽
- 计算密度

### 代码解析
#### 1. 建立的网格相同

#### 2. 通过对于density函数的参数设置

![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/code4.png)

### 结果
![img](https://github.com/cuit201608/Team1_coding/blob/master/1st/screenshots/KDE.png)
