#!/bin/sh

kubectl delete -f ./kubernetes.yaml

image=${DOCKER_REGISTRY_HOST}/${NAME}:${TAG}
sed -i "s#{{IMAGE}}#$image#g" ./kubernetes.yaml
kubectl apply -f ./kubernetes.yaml