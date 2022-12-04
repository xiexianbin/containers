#!/bin/bash

set -x

if [[ "${GH_SERVER}"x == ""x ]]; then
  GH_SERVER="github.com"
fi
sed "s/GH_SERVER/${GH_SERVER}/g" -i /srv/jekyll-hook/config.json

if [[ "${IS_PUBLIC_REPO}"x == ""x ]]; then
  IS_PUBLIC_REPO=true
  sed "s/IS_PUBLIC_REPO/${IS_PUBLIC_REPO}/g" -i /srv/jekyll-hook/config.json
else
  sed "s/IS_PUBLIC_REPO/${IS_PUBLIC_REPO}/g" -i /srv/jekyll-hook/config.json
  echo "$ID_RSA" > ~/.ssh/id_rsa
  chmod 400 ~/.ssh/id_rsa
  # ssh-agent bash
  ssh-add ~/.ssh/id_rsa
fi

if [[ "${WEB_HOOK_SECRET}"x == ""x ]]; then
  WEB_HOOK_SECRET="web_hook_secret"
fi
sed "s/WEB_HOOK_SECRET/${WEB_HOOK_SECRET}/g" -i /srv/jekyll-hook/config.json

if [[ "${EMAIL_IS_ACTIVATED}"x == ""x ]]; then
  EMAIL_IS_ACTIVATED=false
  sed "s/EMAIL_IS_ACTIVATED/${EMAIL_IS_ACTIVATED}/g" -i /srv/jekyll-hook/config.json
else
  EMAIL_IS_ACTIVATED=true
  sed "s/EMAIL_IS_ACTIVATED/${EMAIL_IS_ACTIVATED}/g" -i /srv/jekyll-hook/config.json
  sed "s/EMAIL_USER/${EMAIL_USER}/g" -i /srv/jekyll-hook/config.json
  sed "s/EMAIL_PASSWORD/${EMAIL_PASSWORD}/g" -i /srv/jekyll-hook/config.json
  sed "s/EMAIL_HOST/${EMAIL_HOST}/g" -i /srv/jekyll-hook/config.json
  sed "s/EMAIL_PORT/${EMAIL_PORT}/g" -i /srv/jekyll-hook/config.json
  sed "s/EMAIL_TLS/${EMAIL_TLS}/g" -i /srv/jekyll-hook/config.json
  sed "s/EMAIL_SSL/${EMAIL_SSL}/g" -i /srv/jekyll-hook/config.json
  sed "s/NOTIFY_EMAIL/${NOTIFY_EMAIL}/g" -i /srv/jekyll-hook/config.json
fi

if [[ "${GITHUB_ACCOUNTS}"x == ""x ]]; then
  GITHUB_ACCOUNTS="xiexianbin"
fi
sed "s/GITHUB_ACCOUNTS/${GITHUB_ACCOUNTS}/g" -i /srv/jekyll-hook/config.json

echo "===== env is: ====="
echo "GH_SERVER=$GH_SERVER"
echo "IS_PUBLIC_REPO=$IS_PUBLIC_REPO"
echo "WEB_HOOK_SECRET=$WEB_HOOK_SECRET"
echo "EMAIL_IS_ACTIVATED=$EMAIL_IS_ACTIVATED"
echo "EMAIL_USER=$EMAIL_USER"
echo "EMAIL_PASSWORD=$EMAIL_PASSWORD"
echo "EMAIL_HOST=$EMAIL_HOST"
echo "EMAIL_PORT=$EMAIL_PORT"
echo "EMAIL_TLS=$EMAIL_TLS"
echo "EMAIL_SSL=$EMAIL_SSL"
echo "GITHUB_ACCOUNTS=$GITHUB_ACCOUNTS"
echo "ID_RSA=$ID_RSA"
echo "======= end ======="

git config --global user.name "$GITHUB_ACCOUNTS"
git config --global user.email "me@xiexianbin.cn"

# start service
mv /etc/nginx/conf.d/jekyll_hook.conf /etc/nginx/conf.d/jekyll_hook.conf.bak
rm -rf /etc/nginx/conf.d/*.conf
mv /etc/nginx/conf.d/jekyll_hook.conf.bak /etc/nginx/conf.d/jekyll_hook.conf
rc-service nginx stop
rc-service nginx start
rc-service nginx reload

cd /srv/jekyll-hook
forever start jekyll-hook.js
forever list

# tailf logs
tail -f ~/.forever/*.log
