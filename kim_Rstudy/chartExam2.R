library(dplyr)
mpg <- data.frame(ggplot2::mpg)

# 문제1
plot(mpg$cty, mpg$hwy,
     xlab = '도시연비', ylab = '고속도로연비',
     pch='+')

# 문제2
table(mpg$drv) %>% barplot(col=rainbow(3))

# 문제3
par(xpd=T)
boxplot(hwy~manufacturer, data = mpg,
        las=2, ylim = c(5,40),
        col = heat.colors( n_distinct(mpg$manufacturer)),
        main='*제조사별 고속도로 연비*', col.main='deep pink',
        xlab = '', ylab = '고속도로연비')

# 문제3-2 : 박스 크기 맞추기
par(xpd=T)
boxplot(hwy~manufacturer, data = mpg,
        las=2, ylim = c(5,40),
        col = heat.colors( n_distinct(mpg$manufacturer)),
        main='*제조사별 고속도로 연비*', col.main='deep pink',
        xlab = '', ylab = '고속도로연비',
        axes=F)
axis(1, at=1:15, lab=c(unique(mpg$manufacturer)), pos =5)
axis(2, at=seq(5, 40, 5))
rect(-0.1, 5, 16.1, 40)
