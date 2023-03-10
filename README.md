# jenkins-python
### `jenkin` + `kubernetes` + `gitlab` 集成测试用例（配置见`Jenkinsfile`）
![](https://raw.githubusercontent.com/tomoncle/img/master/20191019170131.png)

### `gitee` + `drone` + `docker-registry` 集成测试用例（配置见`.drone.yml`）
![](https://raw.githubusercontent.com/tomoncle/img/master/drone-python.jpg)

## `pod` 滚动升级实现：
* 1.修改`{{version}}` 实现对 `deployment` 资源的更新.

* 2.执行更新操作: `kubectl apply -f ./kubernetes.yaml`.

* 3.关键配置：
```yaml
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: jenkins-python
  labels:
    version: "{{VERSION}}"
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins-python
  template:
    metadata:
      labels:
        app: jenkins-python
        version: "{{VERSION}}"
```

* 4.效果：
```bash
[root@kube-master ~]# kubectl get po
NAME                              READY   STATUS              RESTARTS   AGE
jenkins-f44f789bf-s7dxm           1/1     Running             0          2d
jenkins-python-65d496447c-w2nrd   1/1     Running             0          2m35s
jenkins-python-6f84d9fc97-2wr5s   0/1     ContainerCreatin
...
[root@kube-master ~]# kubectl get po
NAME                              READY   STATUS        RESTARTS   AGE
jenkins-f44f789bf-s7dxm           1/1     Running       0          2d
jenkins-python-65d496447c-w2nrd   1/1     Terminating   0          2m41s
jenkins-python-6f84d9fc97-2wr5s   1/1     Running       0          18s
...
[root@kube-master ~]# kubectl get po
NAME                              READY   STATUS        RESTARTS   AGE
jenkins-f44f789bf-s7dxm           1/1     Running       0          2d
jenkins-python-6f84d9fc97-2wr5s   1/1     Running       0          30s
```
