# Github TIL

## 1. Git Problems

( 관련 링크 - [https://github.com/sam351/git](N행시 실습) )

### (1) Add 했던 파일 일부 취소하기

- ```bash
  $ git rm --cached < 파일명 >   # staging 되어 있던 파일 취소
  ```

- ```bash
  $ git rm -r --cached .  # staging되어 있던 모든 파일 취소
  ```

</br>

### (2) Commit -m 메세지 내용 수정하기

- 가장 최근의 commit 메세지만 수정 가능 (그 전의 메세지는 수정하기 매우 어려워 지양)

- 수정 절차

  1. ```bash
     $ git commit --amend  # 최근의 commit 수정모드로 이동
     ```
     
  2. 수정모드로 이동하면 `i` 키 눌러서 끼워넣기 모드 활성화
  
  3. 메세지 수정사항 반영
  
  4. `ESC`로 끼워넣기 모드 종료
  
  5. `:wq` 입력해 저장하고 종료
  
  6. ```bash
     $ git log --oneline  # 로그 한 줄씩 확인
     ```

</br>

### (3) 과거 시점으로 완전히 되돌리기 (commit 삭제)

- 존재하던 commit들이 삭제되어 되돌릴 수 없으므로 유의해서 사용할 것

- ```bash
  $ git reset --hard <해시함수명>  :  해당 시점으로 완전히 돌아감
  ```

</br>

### (4) 다른 브랜치(branch) 만들어서 관리하기

- 원본 코드 버전에 영향을 주지 않으면서, 실험적인 코드를 생성해보고 싶을 때 주로 사용

- ```bash
  
  ```

</br>

### (5) 만들었던 브랜치(branch)를 merge하거나 삭제하기

- 

</br>

</br>



## 2. Merge의 세 가지 시나리오

### (1) Conflict Case

- Github와 Local 사이에 commit이 동일하게 찍히지 않고, 다른 commit이 구성되는 문제
  - ex.  ( Github에서 '파일 a 수정' 및 '파일 b 추가' ) & ( Local에서 '파일 a 수정' 및 '파일 c 추가' )  -  맞나???

</br>

### (2) Solution

- git stash 명령어를 사용해, 현재 변경사항을 다른 저장소에 일시 저장 → working tree를 clean하게 만들 수 있음
- git checkout < hash-function 혹은 master > 로 시점 이동



## 3. 파이썬 기초 문제

### (1) q1.py







## 4. 파이썬 웹 크롤링

### (1) requests 패키지



### (2) bs4 패키지 - BeautifulSoup() 함수





## 5. 파이썬으로 파일 읽고 쓰기

### (1) 파일 쓰기



### (2) 파일 읽기



### (3) with 구문으로 간결하게 만들기





## 6. Github 페이지 만들기 (나만의 이력서)

### (1) Start Bootstrap



### (2) Github Repository 생성



### (3) Github Pages 생성







```bash

```