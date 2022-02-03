id <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
grade <- c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5)
mid <- c(20,23,26,11,22,29,34,37,15,14,26,15,24,24,33,19,11,27,34,21) 
fin <- c(33,39,21,11,16,12,30,29,26,25,27,25,11,10,33,25,18,33,21,34)

install.packages("dplyr")
library(dplyr)

score= data.frame(id,grade,mid,fin)
score

# 데이터를 그룹별로 묶어주기 
# 각 반별로 묶어주는 방법 group_by()
# 단순히 group_by()만 사용하지 않는다
# group_by()와 함께 자주 사용되는 함수는
# summarise() 함수와 같이 사용된다.
# summarise() 함수는 요약통계량을 볼 수 있는 함수
 score %>%  group_by(grade) %>% summarise(m_mid=mean(mid))
 score %>%  group_by(grade) %>% summarise(m_mid=max(mid))
 score %>%  group_by(grade) %>% summarise(IQR=IQR(mid)) # IQR = 사분위수
 
 
 #dataframe 합치기
 mid = data.frame(id=c(101,102,103,104,105), mid =c(60,80,70,90,85))
fin=data.frame(id=c(103,104,105,106,107),fin=c(70,83,65,50,75)) 

# innserJoin 내부 공통으로 가지고 있는 행만 결합
inner_join(mid,fin, by="id")

# full_join 두개의 데이터프레임을 합함
full_join(mid,fin,by="id")

# left_join 왼쪽을 기준으로 병합
left_join(mid,fin,by="id")

# right_join 오른쪽을 기준으로 병합
right_join(mid,fin,by="id")

# 데이터 합치기 (행) bind_rows()
mid
mid2= data.frame(id=c(106,107), mid=c(85,77))
mid
mid2
 
bind_rows(mid, mid2)

# 실습) 항공데이터 분석하기
install.packages("hflights")
library(hflights)
dim(hflights)
View(hflights)

# 비행기 번호판별 가장 오래걸린 출발시간을 출력 
hflights %>%  group_by(TailNum) %>% summarise(DepTime=max(DepTime, na.rm=T))
# 결항건수가 가장 많았던 날 알아내기
# 결항사유별 건수를 출력
hflights %>%  group_by(CancellationCode) %>% summarise(n=n())

# 실습2) 결항 사유가 날씨 이거나 기류상황인 데이터만 출력하시오.

# 월별 건수출력
hflights %>%  filter(CancellationCode=="B"| CancellationCode=="C") %>%group_by(Month) %>% summarise(n=n()) %>%  arrange(desc(n))


hflights %>%  filter(CancellationCode=="B"| CancellationCode=="C") %>%group_by(Month, DayofMonth) %>%  summarise(n=n()) %>% arrange(desc(n))


list.files()
library(readxl)

score= read_excel("score.xlsx")
score

# na(결측치)를 파악하는 함수
# na가 있으면 True 
is.na(score) #is -> boolean 으로 반환
# T/F 개수를 출력하시오

table(is.na(score))

# 속성(컬럼)별 na의 개수 출력
summary(score)

# filter를 활용해 mid안에 결측치가 없은행만 출력
score %>% filter(!is.na(mid)) # true-> false /false ->true

# filter를 활용하여 전체 결측치가 있는 행을 제거
score %>% filter(!is.na(mid)&!is.na(fin)&!is.na(assign)&!is.na(att))

score %>% na.omit()

# 중앙값 알아내기
median(score$mid, na.rm = T)

# 실습) mid안에 결측치가 있다면 중앙값으로 대체해라
score$mid = ifelse(is.na(score$mid), 25, score$mid)
score$mid

boxplot(score$mid)
score$mid= ifelse(score$mid>100, 25, score$mid) 
score$mid
