library(ggmap)
my_key  # <- "google api key"
register_google(key=my_key)

my_addr <- ('맷돌로 50 보미청광아파트')
my_gc <- geocode(location = my_addr)

tmp_sec <- as.integer(format(Sys.time(), format = '%S'))
if( tmp_sec>=45 ) {
  tmp_maptye <- "hybrid"
} else if( tmp_sec>=30 ) {
  tmp_maptye <- "roadmap"
} else if( tmp_sec>=15 ) {
  tmp_maptye <- "satellite"
} else {
  tmp_maptye <- "terrain"
}
map <- get_googlemap( center=c(my_gc$lon, my_gc$lat),
                      maptype = tmp_maptye, zoom=15, 
                      markers = my_gc)
ggmap(map) + 
  geom_text(aes(my_gc$lon, my_gc$lat), 
            label = '나의 집') +
  labs(title = "나의 집", x='경도', y='위도')

ggsave('mymap.png')


