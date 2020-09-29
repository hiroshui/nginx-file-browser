#!/bin/bash
set -eu

echo "[INFO]: Read configs (user.conf, image.conf)"
source user.conf
source image.conf

echo "[INFO]: Build image with settings from config".
sudo docker build -t ${IMAGE_NAME}:${IMAGE_TAG} --build-arg password="${PASSWORD}" --build-arg username="${USERNAME}" .


