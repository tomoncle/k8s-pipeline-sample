#!/bin/sh

image=${DOCKER_REGISTRY_HOST}/${NAME}:${TAG}
sed -i "s#{{IMAGE}}#$image#g" ./kubernetes.yaml
cat ./kubernetes.yaml

kubectl get po
kubectl delete -f ./kubernetes.yaml > /dev/null 2>&1
kubectl apply -f ./kubernetes.yaml
