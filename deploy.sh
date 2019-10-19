#!/bin/sh

image=${DOCKER_REGISTRY_HOST}/${NAME}:${TAG}
sed -i "s#{{IMAGE}}#$image#g" ./kubernetes.yaml
cat ./kubernetes.yaml
cat ~/.kube/config
kubectl get po
kubectl delete -f ./kubernetes.yaml
kubectl apply -f ./kubernetes.yaml
