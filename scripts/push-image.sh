#!/bin/sh
set -exu
. ./scripts/config.sh

docker push ${docker_image_name}:${docker_image_tag}
