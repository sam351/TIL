library(dplyr)
log <- read.table('data/product_click.log', stringsAsFactors = F)


# 문제 1
str(log)

png(filename = 'clicklog1.png', width = 700)

barplot( height = table(log$V2),
         main = '세로바 그래프 실습',
         col=terrain.colors(10),
         xlab='상품ID', ylab='클릭수')

dev.off()


# 문제 2
str(log)

log$V1 <- as.character(log$V1)
log <- log %>%
  mutate( hour = as.POSIXlt(log$V1, format='%Y%m%d%H%M')$hour )

bin_df <- 
  as.data.frame(table(log$hour), stringsAsFactors = F ) %>% 
    mutate( hour_bin = paste0(Var1,'~',as.integer(Var1)+1) )
str(bin_df)


png(filename = 'clicklog2.png', width = 700)

pie(bin_df$Freq,
    labels = bin_df$hour_bin,
    col = rainbow(18),
    main = '파이그래프 실습')

dev.off()

