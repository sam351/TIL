
# < 거리 개념과 다차원척도(MultiDimensional Scaling) >

# 1. 학생 데이터 MDS 계산
academy = read.csv('MLData/academy.csv',
                   stringsAsFactors = F, header = T)
academy = academy[-1]
academy[1:2, ]
str(academy)

dist_academy = dist(academy, method = "euclidean")
dist_academy
str(dist_academy)

two_coord = cmdscale(dist_academy); two_coord
plot(two_coord)
text(two_coord, as.character(1:52))

academy$학업집중도

academy[c(1,15),]



# 2. 메뉴 데이터 MDS 계산
food = read.csv('MLData/food.csv', stringsAsFactors = F,
                header = T)
food = food[-1]
head(food)

dist(t(food))  # 잘못된 방법 (단순 뺄셈이라 1,-1과 0,0을 같은 것으로 취급)
food_mult = t(as.matrix(food)) %*% as.matrix(food)  # 옳은 방법
food_mult

dist_food = dist(food_mult)
dist_food

two_coord2 = cmdscale(dist_food)
plot(two_coord2, type = 'n')
text(two_coord2, rownames((food_mult)))
