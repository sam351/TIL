# Anaconda env (20.01.15)

( conda ver. 4.7.12 )

## 1. Create anaconda env

- 아나콘다 가상환경을 생성하는 명령어는 아래 두 가지로 알려져 있음.
- 아나콘다는 가상환경이 생성되는 경로가 기본으로 세팅되어 있기 때문에, 파이썬 가상환경처럼 특정 디렉토리로 이동할 필요가 없음
- 설치 중 업데이트와 관련된 확인 메세지가 뜨면, `y`를 입력해 업데이트하는 것이 권장되고 있음

``` anaconda prompt
> conda create -n env_name
```

```anaconda prompt
> conda create --name env_name
```

- **( 주의! )** 아래와 같이 가상환경 이름 뒤에 python 버전을 명시해주지 않으면, python이 Path에 추가되어 있지 않거나 설치되어 있지 않은 경우 문제가 발생할 수 있음
- (처음에 가상환경 생성 시, 파이썬 버전을 명시하지 않은 가상환경을 만들었다가 pip 등이 존재하지 않아 불편을 겪었음)

```anaconda prompt
> conda create -n env_name python=3.7.4
```





## 2. Check status

- 잘 설치되었는지 확인하려면, 아래 명령어를 통해 가상환경 목록을 확인

```anaconda prompt
> conda info --envs
```





## 3. Activate/Deactivate env

### (1) 가상환경 시작, 사용하기

- 가상환경을 시작하려면, 어떤 디렉토리에서든 아래 명령어를 통해 바로 시작 가능

```anaconda prompt
> activate env_name
```

- 가상환경을 시작한 후 다양한 패키지를 설치해도, 기존 환경에는 영향을 주지 않음.
- 가상환경에서 jupyter notebook이 실행되지 않는 경우, 아래 명령어를 통해 설치 후 실행하면 됨
```anaconda prompt
(env_name) > pip install jupyter notebook
```

- conda 명령어로도 패키지 설치가 가능함
- **( 의문 )** 가상환경 내에서 pip 설치와 conda 설치의 차이가 뭘까?

```anaconda prompt
(env_name) > conda install pandas
```

- 가상환경에서 각종 패키지를 설치하며 사용한 뒤, 아래 명령어를 통해 확인해보면 가상환경 바깥의 패키지 목록과 다르다는 사실을 확인할 수 있음

```anaconda prompt
(env_name) > conda list
```

```anaconda prompt
(env_name) > pip list
```



### (2) 가상환경 종료하기


- 가상환경을 종료할 때는 앞에 conda를 명시해야 함 (기존 deactivate 명령어는 deprecated 되었음)
```anaconda prompt
(env_name) > conda deactivate
```





## 4. Remove anaconda env

- 가상환경을 삭제하기 위한 명령어는 아래 두 가지로 알려져 있음. 
- ( 주의! ) 가상환경 삭제는 해당 가상환경을 종료한 상태에서만 가능함

```anaconda prompt
> conda env remove -n env_name
```

```anaconda prompt
> conda remove -n env_name --all
```

- 잘 삭제되었는지 확인하려면, 아래 명령어를 통해 가상환경 목록을 확인

```anaconda prompt
> conda info --envs
```

- 그러나 정상적으로 삭제된 경우에도, 해당 경로로 들어가보면 디렉토리가 완전히 삭제되어 있지 않은 상태임.
- 이로 인해 같은 이름의 env를 새로 생성할 경우, 덮어씌울 것인지 물어보는 메세지가 등장함.



