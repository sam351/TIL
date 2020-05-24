library(dplyr)


# 문제7
# 7-1 ~ 7-2
mpg <- data.frame(ggplot2::mpg)
mpg_copy <- mpg
mpg_copy <- mpg_copy %>% mutate( tot_eff = cty+hwy,
                                 mean_eff = (cty+hwy)/2 )
# 7-3
mpg_copy %>% arrange(desc(mean_eff)) %>% head(3)

# 7-4
mpg %>% 
  mutate( tot_eff = cty+hwy,
          mean_eff = (cty+hwy)/2 ) %>% 
  arrange(desc(mean_eff)) %>% 
  head(3)
  


# 문제8
# 8-1
mpg %>% 
  group_by(class) %>% 
  summarise(cty_by_class = mean(cty))

# 8-2
mpg %>% 
  group_by(class) %>% 
  summarise(cty_by_class = mean(cty)) %>% 
  arrange(desc(cty_by_class))

# 8-3
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(hwy_by_manufacturer = mean(hwy)) %>% 
  arrange(desc(hwy_by_manufacturer)) %>% 
  head(3)

# 8-4
mpg %>% 
  filter( class=='compact' ) %>% 
  group_by(manufacturer) %>% 
  summarise(no_compact = n()) %>% 
  arrange(desc(no_compact))



# 문제9
fuel <- data.frame( fl=c('c','d','e','p','r'),
                    price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                    stringsAsFactors = F); fuel
# 9-1
mpg <- mpg %>% left_join(fuel, by='fl')

# 9-2
mpg %>% select('model','fl','price_fl') %>% head(5)



# 문제10
midwest <- data.frame(ggplot2::midwest)
str(midwest)
?midwest

# 10-1
midwest <- midwest %>% 
  mutate(minor_pct = (poptotal-popadults)/poptotal*100 )

# 10-2
midwest %>% 
  arrange(desc(minor_pct)) %>% 
  head(5) %>% 
  select(county, minor_pct)

# 10-3
midwest %>% 
  mutate( minor_indicator = 
            ifelse(minor_pct>=40, 'large',
                   ifelse(minor_pct>=30, 'middle', 'small')) ) %>% 
  group_by( minor_indicator ) %>% 
  summarise( num = n() )

# 10-4
midwest %>% 
  mutate( asian_pct = popasian/poptotal*100 ) %>% 
  arrange(asian_pct) %>% 
  head(10) %>% 
  select(state, county, asian_pct)



# 문제11
mpg <- data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212), "hwy"] <- NA

# 11-1
table(is.na(mpg$drv))  # 결측치 없음
table(is.na(mpg$hwy))  # 결측치 5개

# 11-2
mpg %>% 
  filter( !is.na(hwy) ) %>% 
  select( drv, hwy ) %>% 
  group_by( drv ) %>% 
  summarise( mean_hwy = mean(hwy) ) %>% 
  arrange(desc(mean_hwy))  # drv==f 가 28.2로 가장 높음



# 문제12
mpg <- data.frame(ggplot2::mpg)
mpg[c(10,14,58,93), 'drv'] <- 'k'
mpg[c(29,43,129,203), 'cty'] <- c(3,4,39,42)

# 12-1
table(mpg$drv)  # 이상치 'k' 발견
mpg[ !mpg$drv %in% c('4','f','r'),'drv' ] <- NA

table(mpg$drv)  # 이상치 NA처리 확인
table(is.na(mpg$drv))  # 이상치 NA처리 확인

# 12-2
boxplot(mpg$cty)
boxplot(mpg$cty)$stats  # 9 미만 또는 26 초과이면 이상치 간주

mpg[(mpg$cty<9 | mpg$cty>26), 'cty'] <- NA
table(is.na(mpg$cty))  # 이상치 9개 제외 확인
boxplot(mpg$cty)  # 이상치 9개 제외 확인

# 12-3
mpg %>% 
  select(drv, cty) %>% 
  filter( !is.na(drv) ) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty, na.rm = T))

# 12-3 another way
mpg %>% 
  select(drv, cty) %>% 
  na.omit() %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))
