#!/bin/bash

cnpm config set registry https://registry.cnpm.taobao.org

if [ "$(ls -A /gitbook/.ssh 2>/dev/null)" ]; then 
    echo "*****[Gitbook] /gitbook/.ssh directory exists and has content, continuing *****"; 
else 
    echo "*****[Gitbook] /gitbook/.ssh directory is empty, initialising ssh key and configuring known_hosts for common git repositories (github/gitlab) *****" 
    rm -rf ~/.ssh/* 
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P "" 
    ssh-keyscan github.com > ~/.ssh/known_hosts 2>/dev/null 
    ssh-keyscan gitlab.com >> ~/.ssh/known_hosts 2>/dev/null 
    cp -r ~/.ssh /gitbook; 
fi; 

echo "*****[Gitbook] Running git config, user = ${GIT_USER}, email = ${GIT_EMAIL} *****" 
git config --global user.email ${GIT_EMAIL} 
git config --global user.name ${GIT_USER} 
echo "*****[Gitbook] Copying .ssh from gitbook directory and setting permissions *****" 
cp -r /gitbook/.ssh ~/ 
chmod 600 ~/.ssh/id_rsa 
chmod 600 ~/.ssh/id_rsa.pub 
chmod 700 ~/.ssh 
echo "*****[Gitbook] Contents of public ssh key (for deploy) - *****" 
cat ~/.ssh/id_rsa.pub 

if [ ! -f /gitbook/useRun.sh ]; then 
    echo "[Gitbook]cp useRun.sh"
    cp /useRun.sh /gitbook/useRun.sh; 
    chmod +x /gitbook/useRun.sh;
    /gitbook/useRun.sh; 
else 
    echo "[Gitbook]run useRun.sh"
    /gitbook/useRun.sh; 
fi
