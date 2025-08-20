Started by user Fizza Naseer

Obtained Jenkinsfile from git https://github.com/Fizza424/Final-Devops-Project.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins
 in C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential fizzanaseer424@gmail.com
 > C:\Program Files\Git\cmd\git.exe rev-parse --resolve-git-dir C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2\.git # timeout=10
Fetching changes from the remote Git repository
 > C:\Program Files\Git\cmd\git.exe config remote.origin.url https://github.com/Fizza424/Final-Devops-Project.git # timeout=10
Fetching upstream changes from https://github.com/Fizza424/Final-Devops-Project.git
 > C:\Program Files\Git\cmd\git.exe --version # timeout=10
 > git --version # 'git version 2.49.0.windows.1'
using GIT_ASKPASS to set credentials 
 > C:\Program Files\Git\cmd\git.exe fetch --tags --force --progress -- https://github.com/Fizza424/Final-Devops-Project.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > C:\Program Files\Git\cmd\git.exe rev-parse "refs/remotes/origin/main^{commit}" # timeout=10
Checking out Revision 220d92944af3179a140f95036c9b345bf8efef01 (refs/remotes/origin/main)
 > C:\Program Files\Git\cmd\git.exe config core.sparsecheckout # timeout=10
 > C:\Program Files\Git\cmd\git.exe checkout -f 220d92944af3179a140f95036c9b345bf8efef01 # timeout=10
Commit message: "Update Dockerfile"
 > C:\Program Files\Git\cmd\git.exe rev-list --no-walk 220d92944af3179a140f95036c9b345bf8efef01 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential pat
 > C:\Program Files\Git\cmd\git.exe rev-parse --resolve-git-dir C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2\.git # timeout=10
Fetching changes from the remote Git repository
 > C:\Program Files\Git\cmd\git.exe config remote.origin.url https://github.com/Fizza424/Final-Project.git # timeout=10
Fetching upstream changes from https://github.com/Fizza424/Final-Project.git
 > C:\Program Files\Git\cmd\git.exe --version # timeout=10
 > git --version # 'git version 2.49.0.windows.1'
using GIT_ASKPASS to set credentials GitHub HTTPS with PAT
 > C:\Program Files\Git\cmd\git.exe fetch --tags --force --progress -- https://github.com/Fizza424/Final-Project.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > C:\Program Files\Git\cmd\git.exe rev-parse "refs/remotes/origin/main^{commit}" # timeout=10
Checking out Revision ea7a5260c59b4182e1cfcdb807f6009eb552fcd1 (refs/remotes/origin/main)
 > C:\Program Files\Git\cmd\git.exe config core.sparsecheckout # timeout=10
 > C:\Program Files\Git\cmd\git.exe checkout -f ea7a5260c59b4182e1cfcdb807f6009eb552fcd1 # timeout=10
 > C:\Program Files\Git\cmd\git.exe branch -a -v --no-abbrev # timeout=10
 > C:\Program Files\Git\cmd\git.exe branch -D main # timeout=10
 > C:\Program Files\Git\cmd\git.exe checkout -b main ea7a5260c59b4182e1cfcdb807f6009eb552fcd1 # timeout=10
Commit message: "Add files via upload"
 > C:\Program Files\Git\cmd\git.exe rev-list --no-walk ea7a5260c59b4182e1cfcdb807f6009eb552fcd1 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (List files in workspace)
[Pipeline] powershell


    Directory: C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
d-----         8/20/2025   9:27 PM                Final project                                                        
-a----         8/20/2025   9:27 PM            200 Dockerfile                                                           
-a----         8/20/2025   9:27 PM           1500 Jenkinsfile                                                          
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build Docker image)
[Pipeline] powershell
powershell.exe : #0 building with "default" instance using docker driver
At C:\ProgramData\Jenkins\.jenkins\workspace\devops-demo-pipeline2@tmp\durable-4f6a76a6\powershellWrapper.ps1:3 char:1
+ & powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -Comm ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (#0 building wit...g docker driver:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 30B 0.1s
#1 transferring dockerfile: 239B 0.1s done
#1 DONE 0.2s

#2 [internal] load metadata for docker.io/library/node:18-alpine
#2 DONE 0.2s

#3 [internal] load .dockerignore
#3 transferring context: 2B 0.0s done
#3 DONE 0.1s

#4 [internal] load build context
#4 ...

#5 [1/5] FROM docker.io/library/node:18-alpine@sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e
#5 resolve docker.io/library/node:18-alpine@sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e 0.3s done
#5 DONE 0.3s

#4 [internal] load build context
#4 transferring context: 67.05kB 0.6s done
#4 DONE 0.7s

#6 [2/5] WORKDIR /usr/src/app
#6 CACHED

#7 [3/5] COPY package*.json ./
#7 CACHED

#8 [4/5] RUN npm ci --omit=dev
#8 5.163 npm error code EUSAGE
#8 5.166 npm error
#8 5.166 npm error The `npm ci` command can only install with an existing package-lock.json or
#8 5.166 npm error npm-shrinkwrap.json with lockfileVersion >= 1. Run an install with npm@5 or
#8 5.166 npm error later to generate a package-lock.json file, then try again.
#8 5.166 npm error
#8 5.166 npm error Clean install a project
#8 5.166 npm error
#8 5.166 npm error Usage:
#8 5.166 npm error npm ci
#8 5.166 npm error
#8 5.166 npm error Options:
#8 5.166 npm error [--install-strategy <hoisted|nested|shallow|linked>] [--legacy-bundling]
#8 5.166 npm error [--global-style] [--omit <dev|optional|peer> [--omit <dev|optional|peer> ...]]
#8 5.166 npm error [--include <prod|dev|optional|peer> [--include <prod|dev|optional|peer> ...]]
#8 5.166 npm error [--strict-peer-deps] [--foreground-scripts] [--ignore-scripts] [--no-audit]
#8 5.166 npm error [--no-bin-links] [--no-fund] [--dry-run]
#8 5.166 npm error [-w|--workspace <workspace-name> [-w|--workspace <workspace-name> ...]]
#8 5.166 npm error [-ws|--workspaces] [--include-workspace-root] [--install-links]
#8 5.166 npm error
#8 5.166 npm error aliases: clean-install, ic, install-clean, isntall-clean
#8 5.166 npm error
#8 5.166 npm error Run "npm help ci" for more info
#8 5.195 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-08-20T16_27_51_002Z-debug-0.log
#8 ERROR: process "/bin/sh -c npm ci --omit=dev" did not complete successfully: exit code: 1
------
 > [4/5] RUN npm ci --omit=dev:
5.166 npm error [--include <prod|dev|optional|peer> [--include <prod|dev|optional|peer> ...]]
5.166 npm error [--strict-peer-deps] [--foreground-scripts] [--ignore-scripts] [--no-audit]
5.166 npm error [--no-bin-links] [--no-fund] [--dry-run]
5.166 npm error [-w|--workspace <workspace-name> [-w|--workspace <workspace-name> ...]]
5.166 npm error [-ws|--workspaces] [--include-workspace-root] [--install-links]
5.166 npm error
5.166 npm error aliases: clean-install, ic, install-clean, isntall-clean
5.166 npm error
5.166 npm error Run "npm help ci" for more info
5.195 npm error A complete log of this run can be found in: /root/.npm/_logs/2025-08-20T16_27_51_002Z-debug-0.log
------
Dockerfile:6
--------------------
   4 |     # Install dependencies
   5 |     COPY package*.json ./
   6 | >>> RUN npm ci --omit=dev
   7 |     
   8 |     # Copy sources
--------------------
ERROR: failed to build: failed to solve: process "/bin/sh -c npm ci --omit=dev" did not complete successfully: exit code: 1
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Push to Docker Hub)
Stage "Push to Docker Hub" skipped due to earlier failure(s)
[Pipeline] getContext
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Deploy to EC2)
Stage "Deploy to EC2" skipped due to earlier failure(s)
[Pipeline] getContext
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Backup logs to S3)
Stage "Backup logs to S3" skipped due to earlier failure(s)
[Pipeline] getContext
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 1
Finished: FAILURE


