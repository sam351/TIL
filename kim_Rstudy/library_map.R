library(ggmap)
my_key  # <- "google api key"
register_google(key=my_key)

# 서울특별시 위경도 생성
seoul_addr <- '대한민국 서울특별시'
seoul_gc <- geocode(location = seoul_addr)

# 서울특별시 내 장애인도서관 이름, 위경도 생성
lib_df <- read.csv('data/지역별장애인도서관정보.csv', stringsAsFactors=F)
View(lib_df)
lib_df <- lib_df[c('도서관명', '주소', 'LAT', 'LON')]
str(lib_df)

# 지도 시각화
map <- get_googlemap( center=c(seoul_gc$lon, seoul_gc$lat),
                      maptype = "roadmap", zoom=11)
ggmap(map) + 
  geom_point(data = lib_df, 
             aes(lib_df$LON, lib_df$LAT),
             size=3, color='red',
             alpha=0.5) + 
  geom_text(data = lib_df,
            aes(lib_df$LON, lib_df$LAT),
            label = lib_df$도서관명,
            size=4, vjust=0, hjust=0 )

ggsave('library.png')

