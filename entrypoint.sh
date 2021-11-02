#!/bin/bash

cnpm config set registry https://registry.cnpm.taobao.org

if [ ! -f /gitbook/requirements.txt ]; then 
    echo "*****[Gitbook] Gitbook directory contains no requirements.txt file, continuing *****"; 
else 
    echo "*****[Gitbook] Gitbook directory contains a requirements.txt file, installing cnpm requirements *****"; 
    cat /gitbook/requirements.txt | xargs cnpm --prefer-offline install --save; 
fi; 

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

# userRun.sh
if [ ! -f /gitbook/userRun.sh ]; then 
    echo "[Gitbook]cp userRun.sh"
    cp /userRun.sh /gitbook/userRun.sh; 
    chmod +x /gitbook/userRun.sh;
    /gitbook/userRun.sh; 
else 
    echo "[Gitbook]run userRun.sh"
    /gitbook/userRun.sh; 
fi

# npm config
npm config ls -l

if [ "$(ls -A /gitbook/.cache 2>/dev/null)" ]; then 
    echo "***** /gitbook/.cache directory exists and has content, continuing *****"; 
else 
    echo "***** /gitbook/.cache directory is empty. mkdir -p /gitbook/.cache*****" 
    mkdir -p /gitbook/.cache
fi; 

npm config set cache "/app/.cache/npm" 
yarn config set cache-folder /app/.cache/yarn
