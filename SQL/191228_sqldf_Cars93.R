# setwd("")
rm(list = ls())

# install.packages("sqldf")
library(sqldf)
library(MASS)

# loading data
data(Cars93)
str(Cars93)
summary(Cars93[c('Type', 'MPG.city', 'MPG.highway')])
table(is.na(Cars93[c('Type', 'MPG.city', 'MPG.highway')]))

# aggregate()
agg_mean = aggregate(Cars93[, c(7,8)],
                     by = list(Car_Type = Cars93$Type),
                     FUN = mean,
                     na.rm=T)
agg_mean

# sqldf()
sqldf_1 = sqldf('
      select "Type" as "Car_Type",
              avg("MPG.city") as "mean_MPG.city",
              avg("MPG.highway") as "mean_MPG.highway"
      from Cars93
      group by Type
      order by Type
      ')
sqldf_1

# compare the two tables
Type_mean = merge(agg_mean, sqldf_1, by = 'Car_Type')
Type_mean = transform(Type_mean,
              gap_city = MPG.city - mean_MPG.city,
              gap_hwy = MPG.highway - mean_MPG.highway)
Type_mean

# SQL aggregation func
colnames(Cars93)
sqldf_2 = sqldf('
                select "Type" as "car_type",
                count("MPG.city") as "count_mpg.city",
                sum("MPG.city") as "sum_mpg.city",
                
                avg("MPG.city") as "mean_mpg.city",
                variance("MPG.city") as "var_mpg.city",
                stdev("MPG.city") as "std_mpg.city",
                
                min("MPG.city") as "min_mpg.city",
                max("MPG.city") as "max_mpg.city"
                
                from Cars93
                
                group by Type
                order by Type desc
                ')
sqldf_2


# + in other datasets
data("cars")
str(cars)
mpg = ggplot2::mpg
str(mpg)

sqldf('select * from cars
       group by speed
       order by speed')

sqldf('select
        "manufacturer" as "company",
        "model",
        avg("cty") as "mean_cty",
        avg("hwy") as "mean_hwy"
      from mpg
      
      group by company, model
      order by company, model
      ')
