library(ggmap)
library(leaflet)
library(htmlwidgets)

# 위경도 확보
# register_google(key=my_key)
# my_gc <- geocode(my_addr)

tmp_content <- paste0("<b>나의 집</b><hr/>",
                     '내가 살고 있는 곳')
res_map <- leaflet() %>% 
  addTiles() %>% 
  setView(lng = my_gc$lon, lat = my_gc$lat, 
          zoom = 16) %>% 
  addCircles(lng = my_gc$lon, lat = my_gc$lat,
             col='magenta',
             popup = tmp_content)

saveWidget( res_map , file="mymap.html")


