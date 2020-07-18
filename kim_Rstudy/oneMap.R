# 종로구 동별 1인 가구 수 시각화
library(dplyr)

# 1. 1인가구, korpopmap3, 종로구 91개동 행정코드 dataset 준비
DONG <- read.csv('data/one.csv')
data(korpopmap3)
jongro_codes_df <- 
  read.csv('data/행정구역분류와_행정동_법정동_연계표2_20091231_기준.csv', 
           header=T, stringsAsFactors=F) %>% 
  filter(시군구=='종로구') %>% 
  select(시군구, 행정동, 법정동, 행정구역분류)
jongro_codes_df <- jongro_codes_df[ !is.na(jongro_codes_df$행정구역분류), ]
row.names(jongro_codes_df) <- NULL


# 2. 전처리 - 인코딩 변환
Encoding(names(korpopmap3)) <- 'UTF-8'
Encoding(korpopmap3@data$name_eng) <- 'UTF-8'
Encoding(korpopmap3@data$name) <- 'UTF-8'
Encoding(korpopmap3@data$행정구역별_읍면동) <- 'UTF-8'


# 3. 전처리 - korpopmap3에서 종로구 행정동 코드를 가진 지역만 추출
# View(korpopmap3@data)
# View(korpopmap3@polygons)

# korpopmap3@data %>% class  # dataframe
# korpopmap3@polygons %>% class  # list

tmp_idx <- 
  korpopmap3@data[ korpopmap3@data$code %in% 
                     jongro_codes_df$행정구역분류, ] %>%
  row.names()  %>% as.numeric()  # 종로구 행정코드를 가진 row 인덱스 추출
# tmp_idx %>% length()  # 18개 추출됨

korpopmap3@data <- korpopmap3@data[( 3472+1 - tmp_idx),]
korpopmap3@polygons <- korpopmap3@polygons[( 3472+1 - tmp_idx)]

# korpopmap3@data$name <- gsub('·', '', korpopmap3@data$name)  # skip - 종로구 행정동들은 텍스트 전처리 불필요


# 4. 전처리 - 1인 가구 데이터에서 종로구만 추출해 korpopmap3에 추가
colnames(DONG) <- c('구별','name','일인가구')
dong <- DONG %>% filter(구별=='종로구')
dong %>% ncol
korpopmap3@data %>% ncol
korpopmap3@data <- merge(korpopmap3@data, dong,
                         by.x='name', sort=FALSE)
korpopmap3@data %>% ncol  # ncol 42+2 => 44개 확인


# 5. 지도 준비
mymap <- korpopmap3@data
mypalette <- colorNumeric(palette ='RdYlBu' , 
                          domain = mymap$'일인가구')
mypopup <- paste0(mymap$name,
                  '<br> 1인가구: '
                  ,mymap$'일인가구')


# 6. 지도 시각화
res_map <- leaflet(korpopmap3) %>% 
  addTiles() %>% 
  setView(lat=37.52711, lng=126.987517, zoom=12) %>%
  addPolygons(stroke =FALSE,
              smoothFactor = 0.2,
              fillOpacity = .9,
              popup = mypopup,
              color = ~mypalette(mymap$일인가구)) %>% 
  addLegend( values = ~mymap$일인가구,
             pal =mypalette ,
             title = '인구수',
             opacity = 1)
res_map

saveWidget(res_map, 'oneMap.html')
