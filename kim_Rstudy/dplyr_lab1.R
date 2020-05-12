library(dplyr)
emp <- read.csv('data/emp.csv', stringsAsFactors = F)

# 문제1
emp %>% filter(job=='MANAGER')

# 문제2
emp %>% select(empno, ename, sal)

# 문제3
emp %>% select(-empno)

# 문제4
emp %>% select(ename, sal)

# 문제5
emp %>% 
  group_by(job) %>% summarise(no_ppl = n())

# 문제6
emp %>% 
  filter(sal>=1000 & sal<=3000) %>% 
  select(ename, sal, deptno)

# 문제7
emp %>% 
  filter(job != 'ANALYST') %>% 
  select(ename, job, sal)

# 문제8
emp %>% 
  filter( job %in% c('SALESMAN','ANALYST') ) %>%
  select(ename, job)

# 문제9
emp %>% 
  group_by(deptno) %>% 
  summarise(sum_sal = sum(sal))

# 문제10
emp %>% arrange(sal)

# 문제11
emp %>% arrange(desc(sal)) %>% head(1)

# 문제12
empnew <- emp %>% rename(salary=sal, commrate=comm)

# 문제13
emp %>% 
  group_by(deptno) %>% 
  summarise(no_ppl = n()) %>% 
  arrange(desc(no_ppl)) %>% 
  head(1)[1] %>% as.numeric()

# 문제14
emp %>% 
  mutate(enamelength = nchar(ename)) %>% 
  arrange(enamelength)


# 문제15
emp %>% 
  filter(!is.na(comm)) %>% 
  summarise(n()) %>% 
  as.numeric()

