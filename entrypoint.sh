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

npm config set cache "/gitbook/.cache/npm" 
yarn config set cache-folder /gitbook/.cache/yarn


git config --global user.name ${GIT_USERNAME:-CI}
git config --global user.email ${GIT_USEREMAIL:-ci@17lai.site}

cd /gitbook

print_info(){
    echo ""
    echo "==> $@"
    echo ""
}

main(){

    case $1 in
        server )
            exec gitbook serve
            ;;
        deploy )
            set +x

            if [ -z "$GIT_REPO" ];then
            # check github actions
            test -n "$GITHUB_ACTION" && \
            print_info "RUN on GitHub Actions" && set +x && \
            GIT_REPO="https://${GIT_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}"
            fi

            if [ -z "$GIT_REPO" ];then
            print_info "miss \$GIT_REPO"
            exit 1
            fi

            test -n "$GIT_TOKEN" && \
            print_info "Auth by token" && set +x && \
            GIT_REPO="https://${GIT_USERNAME}:${GIT_TOKEN}@${GIT_REPO}"

            set -x
            cd _book || exit 1

            if [ -d .git ];then
            git remote set-url origin ${GIT_REPO}
            else
            rm -rf .git
            git init
            git remote add origin ${GIT_REPO}
            fi

            git add .
            COMMIT_DATE=`date "+%F %T"`
            git commit -m "${GIT_COMMIT_MESSAGE:-Gitbook updated:} ${COMMIT_DATE}" -s
            git push -f origin master:${GIT_BRANCH:-gh-pages}
            ;;
    esac
    print_info $START
    print_info $(date "+%F %T")
}

main $@