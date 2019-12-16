# Github TIL (191209~191210)

## 1. TIL - new commands

- ```bash
  $ git clone <link>  # copy git repository
  ```

  - To get the link, visit the repository (ex. 'Clone or download' in Github)

- ```bash
  $ touch <file>  # make new file
  ```

- ```bash
  $ git log  # check the whole log
  ```

  - ```bash
    $ git log --oneline  # check only the main logs
    ```

  - ```bash
    $ git log -1  # check only the last log
    ```

- ```bash
  $ git diff  # check the differences made in git
  ```

- ```bash
  $ cat <file>  # print the file on the monitor
  ```


- ```bash
  $ git push origin master  # push the master to origin
  ```

- ```bash
  $ git pull origin master  # pull the origin to master
  ```





## 2. Push & Pull Workflow

### (1) Pull

1. ```bash
   $ git status  # ★ check the status of git (it should be 'working tree clean')
   ```

2. ```bash
   $ git pull origin master   # pull the changes from Github
   $ git log --oneline  # check the log to compare with Github commits
   ```
   
3. Various changes in local folder



### (2) Push

1. Various changes in local folder

2. ```bash
   $ git status  # ★ check the status of git
   ```


3. ```bash
   $ git add <file>  # stage the file for committing
   $ git commit -m "<Commit message>"  # commit the file to git
   ```


4. ```bash
   $ git push origin master  # push the changes to Github
   $ git log --oneline  # check the log to compare with Github commits
   ```


