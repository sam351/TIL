

# 시각화 추가 소스 - visualizing Cars93 df in MASS
library(MASS)
str(Cars93)

ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(shape=21, size=6)

## 선 색상
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(shape=21, size=6, col="blue")
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(col="grey", shape=21, size=6) 

## 채우기 색상
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(shape=21, size=6, fill="blue")   

## aes()는 ggplot()과 geom에 모두 적용 가능
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Price)) + 
  geom_point(col="grey", shape=21, size=6) 
ggplot(Cars93, aes(x=Weight, y=MPG.highway)) + 
  geom_point(col="grey", shape=21, size=6, aes(fill=Price)) 

## 카테고리 데이터 기준으로 색 차별
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(col="grey", shape=21, size=6)

## + scale_fill_brewer(palette="팔레트명") 적용
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(col="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Oranges") # Oranges  
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Reds") # Reds
ggplot(Cars93, aes(x=Weight, y=MPG.highway, fill=Cylinders)) +
  geom_point(colour="grey", shape=21, size=6) +
  scale_fill_brewer(palette="Blues") # Blues





# 연도별 몸무게 데이터 시각화
w <- data.frame(
  year=c("2014", "2015", "2016", "2017", "2018"), 
  weight=c(65,66,64,68,72) )

## year 속성의 빈도 그래프
ggplot(data=w, aes(x=year)) + geom_bar()

## error - geom_bar() 기본함수에는 y축 주면 안 됨
ggplot(data=w, aes(x=year, y=weight)) + geom_bar()

## 각 year별 weight 변화 추이 - geom_bar( stat='identity' )
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(stat="identity")

## + y축 값 범위 설정 - coord_cartesian(ylim = c(m, n) )
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(stat="identity") + 
  coord_cartesian(ylim=c(60, 75))

## + year별 색 차별 - aes(fill= 변수명)
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), stat="identity") + 
  coord_cartesian(ylim=c(60, 75))

## + 선 색상 추가 - geom_bar( col = "색상명" )
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), stat="identity", col="blue") +
  coord_cartesian(ylim=c(60, 75))

## + 그래프 값 라벨 추가 - geom_label( aes(label=변수명), nudge=n )
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), stat="identity") +
  coord_cartesian(ylim=c(60, 75)) + 
  geom_label(aes(label=weight), nudge_y=1.1)
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), stat="identity") +
  coord_cartesian(ylim=c(60, 75)) + 
  geom_label(aes(label=weight), nudge_y=-1.1)

## + 제목, 소제목, x&y축 라벨 추가 - labs(title = , subtitle = , x = , y = )
ggplot(data=w, aes(x=year, y=weight)) + 
  geom_bar(aes(fill=year), stat="identity") + 
  coord_cartesian(ylim=c(60, 75)) + 
  geom_label(aes(label=weight), nudge_y=1.1) +
  labs(title = "테스트", 
       subtitle="ggplot2 패키지를 이용한 시각화", 
       x="년도", y="무게")





# 트리맵 라이브러리 설치
# install.packages("treemap")
# 트리맵 메모리 로드
library(treemap)
library(xlsx)

sales_df <- read.xlsx("data/data.xlsx", 2, encoding="UTF-8")
#-------------------------------------------------------------

# 트리맵 그리기
# index에 표현하고 싶은 계층 순서대로 벡터로 생성. product, region 순으로 벡터를 지정함으로써 product가 region보다 더 상위로 구분이 됨
treemap(sales_df, vSize="saleAmt", index=c("product", "region"), title="A기업 판매현황" )
treemap(sales_df, 
        vSize="saleAmt", 
        index=c("region", "product"), 
        title="A기업 판매현황")
?mpg
성적





# 인터랙티브 그래프 만들기
## 패키지 준비하기
# install.packages("plotly")
library(plotly)
# ggplot으로 그래프 만들기
library(ggplot2)
p <- ggplot(data = mpg, 
            aes(x = displ, y = hwy, col = drv)) + 
  geom_point()
p

## 인터랙티브 그래프 만들기
imsi <- ggplotly(p)
str(imsi)
?ggplotly
?renderTags
library(htmltools)
renderTags(imsi)

## 인터랙티브 막대 그래프 만들기
p <- ggplot(data = diamonds, 
            aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")
ggplotly(p)





# 지도 시각화 - ggmap 패키지
# install.packages("ggmap")
library(ggmap)
register_google(key='AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c')

lon <- 127.0147559
lat <- 37.5431424
cen <- c(lon,lat)
mk <- data.frame(lon=lon, lat=lat)

map <- get_googlemap(center=cen, maptype="roadmap", zoom=14, marker=mk)
ggmap(map)

map <- get_googlemap(center=cen, maptype="satellite", zoom=14, marker=mk)
ggmap(map)

map <- get_googlemap(center=cen, maptype="terrain", zoom=14, marker=mk)
ggmap(map)

map <- get_googlemap(center=cen, maptype="hybrid", zoom=14, marker=mk)
ggmap(map) +
  labs(title="테스트임", x="경도", y="위도")


## 구글 외에 다른 자원을 함께 활용하는 get_map()
map <- get_map(location=cen, maptype="terrain-labels", zoom=14, marker=mk)
ggmap(map)

map <- get_map(location=cen, maptype="toner-hybrid", zoom=14, marker=mk)
ggmap(map)

map <- get_map(location=cen, maptype="watercolor", zoom=14, marker=mk)
ggmap(map)


## 구글에서 특정 지점/위치의 위경도 검색하는 geocode()
mk <- geocode("seoul", source = "google")
print(mk)
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap", zoom=12, marker=mk)
ggmap(map)

mk <- geocode(enc2utf8("부산"), source = "google")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap", zoom=12, marker=mk)
ggmap(map)

학원lonlat <- geocode(enc2utf8("강남구 역삼동 테헤란로 212"), source = "google")
mk <- 학원lonlat
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap", zoom=17)
ggmap(map) + 
  geom_point(aes(x=mk$lon, y=mk$lat), alpha=0.4, size=3, color="deep pink") +
  geom_text(aes(x=mk$lon, y=mk$lat, label="우리가 공부하는 곳", vjust=0, hjust=0))


## 여러 포인트 동시에 시각화 - 제주도 지도
names <- c("용두암", "성산일출봉", "정방폭포",
           "중문관광단지", "한라산1100고지",
           "차귀도")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125")
gc <- geocode(enc2utf8(addr))
gc

df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=10,
                     size=c(640,640),
                     marker=gc)
ggmap(map)
  # + geom_text(aes(x=df$lon, y=df$lat, 
  #               label=df$name, 
  #               vjust=0, hjust=0))  # 실행 안됨





# 공공 DB OPEN API + ggmap 패키지
# install.packages("XML")
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <-
  paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=",
        API_key, "&strSrch=", bus_No, sep="")

doc <- xmlParse(url)
top <- xmlRoot(doc) ; top

df <- xmlToDataFrame(getNodeSet(doc, "//itemList[1]")); df
busRouteId <- df$busRouteId
busRouteId

url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df

## 구글 맵에 버스 위치 출력
df$gpsX <- as.numeric(as.character(df$gpsX))
df$gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=df$gpsX, lat=df$gpsY);gc
cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=gc)
ggmap(map)





# geocode 파라메터 종류
register_google(key='AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c')

geocode('Seoul', source = 'google')
geocode('Seoul', source = 'google', output = 'latlona')  # 영어 주소 추가
geocode(enc2utf8('서울'), source = 'google')
geocode(enc2utf8('서울'), source = 'google', output = 'latlona')
geocode(enc2utf8('서울&language=ko'), source = 'google', output = 'latlona')  # 한국어 주소 추가





# geocode 받아와 df에 추가까지 - mutate_geocode()
#mutate_geocode(data.frame, address_column_name, source = 'google')
station_list = c('시청역', '을지로입구역', '을지로3가역', '을지로4가역', '동대문역사문화공원역', '신당역', '상왕십리역', '왕십리역', '한양대역', '뚝섬역', '성수역', '건대입구역', '구의역', '강변역', '잠실나루역', '잠실역', '신천역', '종합운동장역', '삼성역', '선릉역', '역삼역', '강남역', '2호선 교대역', '서초역', '방배역', '사당역', '낙성대역', '서울대입구역', '봉천역', '신림역', '신대방역', '구로디지털단지역', '대림역', '신도림역', '문래역', '영등포구청역', '당산역', '합정역', '홍대입구역', '신촌역', '이대역', '아현역', '충정로역')

station_df = data.frame(station_list, stringsAsFactors = FALSE)
station_df$station_list = enc2utf8(station_df$station_list)

station_lonlat = mutate_geocode(station_df, station_list, source = 'google')
station_lonlat %>% head

# save(station_lonlat, file="station_lonlat.rda")
# load("station_lonlat.rda") - 할당할 필요 없음

seoul_lonlat = unlist(geocode('seoul', source = 'google'))

?qmap
qmap('seoul', zoom = 11)
qmap(seoul_lonlat, zoom = 11,
     source = 'stamen', maptype = 'toner')

seoul_map <- qmap('Seoul', zoom = 11, 
                  source = 'stamen', maptype = 'toner')
seoul_map + 
  geom_point(data = station_lonlat, 
             aes(x = lon, y = lat), 
             colour = 'green', 
             size = 4)





# 지도 응용
df <- read.csv("data/전국전기차충전소표준데이터.csv", 
               stringsAsFactors=F)       
str(df) 
names(df)
View(df)

df_add <- as.data.frame(df[,14])
View(df_add)
names(df_add) <- c("address")
#head(df_add)
#df_add <- df_add %>% filter(address != "")  
#str(df_add)       
#df_add$address <- as.character(df_add$address)    
#df_add$address <- iconv(df_add$address, from="cp949", to="UTF-8") #UTF-8로 지정해주지 않으면 주소가 모두 NA가 된다.
#head(df_add)

#mut_df_add<-df[, c("경도", "위도")]
#mut_df_add <- mutate_geocode(df_add, address, source="google")

#save(mut_df_add, file="전기차.rda")
load(file="data/전기차.rda")

head(mut_df_add)
map_korea <- get_map(location="southKorea", 
                     zoom=7, maptype="roadmap") 
ggmap(map_korea)

ggmap(map_korea) +
  geom_point(data=mut_df_add,
             aes(x=lon, y=lat),
             alpha=0.5, size=2,color="red")


map_seoul <- get_map(location="seoul",
                     zoom=11, maptype="roadmap")    
ggmap(map_seoul) + 
  geom_point(data=mut_df_add, aes(x=lon, y=lat), 
             alpha=0.5, size=5, color="blue")





# leaflet 그리기
# install.packages("leaflet")
library(leaflet)
library(dplyr)
library(ggmap)

seoul_lonlat <- geocode("seoul")

leaflet()

leaflet() %>% addTiles() 

## Warning - addTiles()하지 않으면 시각화되지 않음
map0 <- leaflet() %>% 
  setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16) 
map0

map1 <- map0 %>% addTiles() 
map1


## 학원 위치 시각화
mk <- 학원lonlat
lan <- mk$lon
lat <- mk$lat
msg <- '<strong><a href="http://www.multicampus.co.kr" style="text-decoration:none" >멀티캠퍼스</a></strong><hr>우리가 공부하는 곳 ㅎㅎ'

map2 <- leaflet() %>% 
  setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% 
  addTiles() %>% 
  addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% 
  setView(lng = mk$lon, lat = mk$lat, zoom = 18) %>% 
  addTiles() %>% 
  addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% 
  setView(lng = mk$lon, lat = mk$lat, zoom = 5) %>% 
  addTiles() %>% 
  addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% 
  setView(lng = mk$lon, lat = mk$lat, zoom = 1) %>% 
  addTiles() %>% 
  addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2


## addPopups()
content1 <- paste(sep = '<br/>',
                  "<b><a href='https://www.seoul.go.kr/main/index.jsp'>서울시청</a></b>",
                  '아름다운 서울','박원순 시장님 화이팅!!')
map3 <- leaflet() %>% 
  addTiles() %>%  
  addPopups(126.97797, 37.56654, content1, options = popupOptions() )
map3

content2 <- paste(sep = '<br/>',
                  "<b><a href='http://www.snmb.mil.kr/mbshome/mbs/snmb/'>국립서울현충원</a></b>",
                  '1955년에 개장', '2013년 ‘서울 미래유산’으로 등재')
map3 <-leaflet() %>% 
  addTiles() %>%  
  addPopups(c(126.97797, 126.97797),  c(37.56654, 37.50124) , 
            c(content1, content2), 
            options = popupOptions(closeButton = FALSE) )
map3


## 다양한 종류의 타일 적용해보기
wifi_data = read.csv('data/wifi_data.csv', 
                     encoding = 'utf-8', stringsAsFactors = FALSE)

leaflet(wifi_data) %>% 
  addTiles() %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], 
          zoom = 11) %>% 
  addCircles(lng = ~lon, lat = ~lat)  # 앞에 ~ 붙인 포뮬러 형식 필수

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addCircles(lng = ~lon, lat = ~lat) %>% 
  addProviderTiles('Stamen.Toner')
  
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addCircles(lng = ~lon, lat = ~lat) %>% 
  addProviderTiles('CartoDB.Positron')

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat, popup = ~div)  # + 팝업 추가


### + 통신사별 다른 색상 적용하기
?colorFactor
telecom_color = colorFactor('Set1', wifi_data$div)

str(telecom_color)
mode(telecom_color)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], 
          lat = seoul_lonlat[2], 
          zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat=~lat, popup = ~div, 
             color = ~telecom_color(div))  # color값 적용





# leaflet과 우리나라 행정구역 지도 활용 - kormaps
# # RStudio 를 재기동한 후에 설치한다.(안하면 재앙이 따를거임!!)
# install.packages("devtools") 
# devtools::install_github("cardiomoon/Kormaps")

## 사전 준비 작업
library(Kormaps)

names(korpopmap1)
names(korpopmap2)
names(korpopmap3)
Encoding(names(korpopmap1)) <-'UTF-8'
Encoding(names(korpopmap2)) <-'UTF-8'
Encoding(names(korpopmap3)) <-'UTF-8'
names(korpopmap1)
names(korpopmap2)
names(korpopmap3)

head(korpopmap1,1)
head(korpopmap2,1)
head(korpopmap3,1)

Encoding(korpopmap2@data$name) <- 'UTF-8'
Encoding(korpopmap2@data$행정구역별_읍면동) <- 'UTF-8'

korpopmap2@data <- korpopmap2@data[-26:-251,]
korpopmap2@polygons<-korpopmap2@polygons[-26:-251]
mymap <- korpopmap2@data
head(mymap)
View(korpopmap2)


## 범죄율 지도 시각화
crime <- read.csv('data/2017crime.csv')
head(crime)
palette1 <- colorNumeric(palette = 'Oranges', 
                         domain = crime$살인_발생)
popup1 <- paste0(mymap$name,'<br> 살인 : ',crime$살인_발생, '건')

map4 <- leaflet(korpopmap2) %>% 
  addTiles() %>% 
  setView(lat=37.559957 ,lng=126.975302 , zoom=11) %>%
  addPolygons(stroke=FALSE, smoothFactor=0.2, fillOpacity=.5,
              popup=popup1, color = ~palette1(crime$살인_발생),
              group='살인')
map4

