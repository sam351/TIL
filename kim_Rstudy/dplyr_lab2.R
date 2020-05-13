library(dplyr)

# 문제1
str(ggplot2::mpg)
mpg <- as.data.frame(ggplot2::mpg)

# 1-1
dim(mpg)
# 1-2
head(mpg, 10)
# 1-3
tail(mpg, 10)
# 1-4
View(mpg)
# 1-5
summary(mpg)

# 1-6
str(mpg)



# 문제2
# 2-1
mpg <- mpg %>% rename(city=cty, highway=hwy)
# 2-2
head(mpg,6)



# 문제3
# 3-1
midwest <- as.data.frame(ggplot2::midwest)
str(midwest)
summary(midwest)
# 3-2
midwest <- midwest %>% rename(total=poptotal,
                              asian=popasian)
# 3-3
midwest <- midwest %>% mutate(asian_percnt = asian/total*100)
# 3-4
mean_asian_percnt <- mean(midwest$asian_percnt)
midwest <- midwest %>% mutate( asian_size = ifelse(asian_percnt > mean_asian_percnt, 'large', 'small') )



# 문제4
mpg <- as.data.frame(ggplot2::mpg)
# 4-1
undr5_mean_hwy <- mpg %>% 
  filter(displ<=4) %>%
  summarise(mean(hwy)) %>% 
  as.numeric()
over4_mean_hwy <- mpg %>% 
  filter(displ>=5) %>%
  summarise(mean(hwy)) %>% 
  as.numeric()
undr5_mean_hwy; over4_mean_hwy  # 따라서 배기량 4 이하인 자동차의 평균 hwy 더 높음
## 윗 문제 더 나은 풀이
mpg %>% 
  mutate( tmp_flag = ifelse(displ<=4, '4&under', ifelse(displ>=5, '5&oevr', 'btw4&5')) ) %>% 
  group_by(tmp_flag) %>% 
  summarise(mean(hwy))

# 4-2
audi_mean_cty <- mpg %>%
  filter(manufacturer=='audi') %>%
  summarise(mean(cty)) %>% 
  as.numeric()
toyota_mean_cty <- mpg %>% 
  filter(manufacturer=='toyota') %>%
  summarise(mean(cty)) %>% 
  as.numeric()
audi_mean_cty; toyota_mean_cty  # 따라서 toyota의 평균 cty 더 높음
## 윗 문제 더 나은 풀이
mpg %>% 
  filter(manufacturer %in% c('audi','toyota')) %>%
  group_by(manufacturer) %>% 
  summarise(mean(cty))

# 4-3
tmp_vec <- unique(mpg$manufacturer)[c(2, 4, 5)]
mpg %>% 
  filter(manufacturer %in% tmp_vec) %>% 
  summarise(mean_hwy = mean(hwy))



# 문제5
mpg <- as.data.frame(ggplot2::mpg)
# 5-1
mpg_new <- mpg %>% select(class, cty)
mpg_new %>% head
# 5-2
mpg_new %>% 
  filter(class=='suv') %>% 
  summarise(mean_cty_suv = mean(cty))
mpg_new %>% 
  filter(class=='compact') %>% 
  summarise(mean_cty_compact = mean(cty))
# 따라서, compact 차종의 평균 cty 더 높음



# 문제6-1
mpg %>% 
  filter(manufacturer=='audi') %>% 
  arrange(desc(hwy)) %>% 
  head(5)

