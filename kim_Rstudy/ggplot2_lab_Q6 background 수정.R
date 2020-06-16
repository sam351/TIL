library(dplyr)
library(ggplot2)

# 문제1
mpg <- data.frame(mpg)
ggplot(mpg, aes(cty, hwy)) + geom_point(col='blue')
ggsave('result1.png')

# 문제2
ggplot(mpg, aes(class, fill=drv)) + geom_bar()
ggsave('result2.png')

# 문제3
midwest <- data.frame(midwest)
options(scipen = 99)
ggplot(midwest, aes(poptotal, popasian)) + 
  geom_point() +
  coord_cartesian( xlim = c(0,500000),
                   ylim = c(0,10000) )
ggsave('result3.png')

# 문제4
mpg_sub <- mpg[mpg$class %in% c("compact", "subcompact", "suv"),]
ggplot(mpg_sub, aes(class, cty)) + geom_boxplot()
ggsave('result4.png')

# 문제5
log_df <- read.table('data/product_click.log', 
                     col.names = c('time','V2'), 
                     stringsAsFactors = F)
str(log_df)
ggplot(log_df, aes(V2, fill=V2)) + geom_bar()
ggsave('result5.png')

# 문제6
log_df$time <- strptime( log_df$time, format='%Y%m%d%H%M' )
log_df$day <- weekdays(log_df$time)
ggplot(log_df, aes(day, fill=day)) + 
  geom_bar() +
  coord_cartesian(ylim = c(0,200)) +
  labs(x='요일', y='클릭수') + 
  # background theme 세부지정
  theme(
    panel.background = 
      element_rect(fill='white', color='black', 
                   size=0.5, linetype='solid'),
    panel.grid.major = 
      element_line('dark gray', 0.5, 'solid'),
    panel.grid.minor = 
      element_line('dark gray', 0.5, 'solid') )
ggsave('result6.png')

