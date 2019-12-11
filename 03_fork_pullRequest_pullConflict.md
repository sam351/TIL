# Github TIL

## 1. Fork & Pull Request

( 관련 링크 - [github.com/sam351/n-haengsi](N행시 실습) )

### (1) Fork

- fork는 특정 프로젝트(repository)를 내 계정의 프로젝트로 끌어오고 싶을 때 사용
- 수정 권한(push authority, commit authority)이 없는 repository라도, fork를 사용해 내 계정으로 끌어오면 수정 가능
- 내가 만든 수정사항을 원래 프로젝트(repository)에 반영(push, commit)하고 싶다면, 권한을 가진 계정에게 'pull request(그 쪽에서 pull 해주기를 요청)'를 보낼 수 있음



### (2) Pull Request

- 원래 commit & push를 통해 프로젝트 수정사항을 반영하려면 contributor의 권한이 있어야 함
- 그러나 권한이 없는 경우에, 권한을 가진 자에게 나의 수정사항을 대신 반영(Pull)해줄 것을 요청(Request)하는 것이 Pull Request
- Pull Request 절차
  1. 해당 프로젝트를 내 계정으로 fork
  2. 내 local로 해당 프로젝트 clone
  3. 수정사항 반영
  4. add → commit → push
  5. 내 계정의 repository → Pull requests 탭 → New pull request 버튼

- 타인의 Pull Request에 대해 댓글 및 이모티콘 가능





## 2. Conflict in Pull

### (1) Conflict Case

- Github와 Local 사이에 commit이 동일하게 찍히지 않고, 다른 commit이 구성되는 문제
  - ex.  ( Github에서 '파일 a 수정' 및 '파일 b 추가' ) & ( Local에서 '파일 a 수정' 및 '파일 c 추가' )  -  맞나???



### (2) Solution

- git stash 명령어를 사용해, 현재 변경사항을 다른 저장소에 일시 저장 → working tree를 clean하게 만들 수 있음
- git checkout < hash-function 혹은 master > 로 시점 이동



