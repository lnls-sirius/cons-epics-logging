#!/bin/sh
set -exu
branch=$(git branch --no-color --show-current)
build_date=$(date -I)
commit=$(git rev-parse --short HEAD)
repository=$(git remote show origin |grep Fetch|awk '{ print $3 }')

docker_registry=docker.io
docker_user_group=lnlscon
docker_image_prefix=${docker_registry}/${docker_user_group}
docker_image_name=${docker_image_prefix}/epics-logging
docker_image_tag=${build_date}-${commit}
