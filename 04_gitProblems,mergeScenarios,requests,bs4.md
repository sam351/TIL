# Github TIL (191211)

## 1. Git Problems

( 관련 링크 - [https://github.com/sam351/git](N행시 실습) )

### (1) Add 했던 파일 일부 취소하기

- `.` 을 사용한 명령어는 가급적 사용하지 말고, 파일 단위로 하나씩 add하는 습관 들일 것!
  
- ```bash
  $ git restore --staged <파일명>  # staging area에 add 된 파일 취소
  ```

- ```bash
  $ git rm --cached < 파일명 >   # track 되고 있던 파일 취소
  ```

- ```bash
  $ git rm -r --cached .  # track 되고 있던 모든 파일 취소 - 사용을 지양할 것!
  ```
  
- ```bash
  $ git reset HEAD  # 실수로 cached 파일을 제거한 경우, 최근 commit 기록으로 소프트 리셋
  ```

- (추가 발견) staging area와 cached는 엄밀히 말하면 다르다. 전자는 commit 할 파일들을 우선 선정하는 단계에 사용하는 단기 기억장소라면, cached는 지속적으로 track하고 있는 파일들의 목록이다. 따라서 cached는 함부로 건드리지 않는 것이 좋다!

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

- 원본 코드 버전에 영향을 주지 않으면서, 실험적인 코드를 생성해보고 싶을 때 주로 사용 (다른 평행우주를 생성해 원본 평행우주에 영향을 미치지 않게 하는 것. '버전관리' 본연의 의미를 살리는 기능)

- ```bash
  $ git branch   # 현재 branch 목록 확인
  ```
  
- ```bash
  $ git branch <brach명>  # 새로운 branch 생성
  ```

- ```bash
  $ git checkout -b test  # test 브랜치 만들고 이동까지 하기
  ```

- (아직 익숙치 않아 추가적인 경험 및 연습이 필요해 보임)

</br>

### (5) 만들었던 브랜치(branch)를 merge하거나 삭제하기

- 실험적 코드가 성공적으로 완성되어, 메인 코드 버전에 합쳐 기능을 확장할 때 주로 사용

- 아직 merge되지 않은 브랜치는 강제하지 않는 이상 git이 삭제를 거부함

- ```bash
  $ git checkout <메인 브랜치명>  # 먼저, 합류하게 될 (메인) 브랜치로 이동
  ```

- ```bash
  $ git merge <합쳐질 브랜치명>  # 여기(메인 브랜치)에, 합쳐질 브랜치를 합류시키는 명령어
  ```

- ```bash
  $ git branch -d <브랜치명>  # 해당 브랜치 삭제
  ```

- ```bash
  $ git branch -D <브랜치명>  # merge되지 않은 브랜치를 강제로 삭제
  ```

</br>

</br>

## 2. Merge의 세 가지 시나리오

### (1) fast-forward

- 브랜치를 만든 이후 master에서 변동사항이 없는 경우, 사실상 master를 (전진) 이동시키기만 하는 것

</br>

### (2) auto-merge

- 브랜치와 master 간에 파일 목록(ls)만 다르고 각 파일별 변동사항이 같은 경우, 파일 목록의 합집합을 만들어주는 것

<br>

### (3) merge conflict

- merge conflict : 브랜치와 master 간에 동일한 파일의 다른 변동사항이 있는 경우, 충돌 발생하는 것 → 사용자가 어떤 버전을 남길지 선택하게 함(vscode)
  - 따로 배우진 않았지만 해당 기능은 아마도 vscode와 git이 연동되어야 가능할 것으로 생각됨

</br>

</br>

## 3. 파이썬 기초 문제

### (1) q1.py ~ q4.py

</br>

</br>

## 4. 파이썬 웹 크롤링

### (1) requests 패키지

- `requests.get( 'url' )` 메서드 : 해당 url의 html 문서를 읽어와 `requests.models.Response` 객체로 리턴
- `.text` 메서드 : `requests.models.Response` 객체에서 html 문서 내용을 `string` 타입으로 리턴

</br>

### (2) bs4 패키지 - BeautifulSoup() 함수

- `BeautifulSoup( response_string, 'html.parser' )` 함수 : `requests.get( 'url' ).text` 으로 리턴받은 `string` 타입의 html 문서를 입력받아 `bs4.BeautifulSoup` 객체로 리턴
  - `.select(태그명)`, `.select_one('태그명')` 매서드를 활용해 html 문서 파싱

</br>

</br>

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