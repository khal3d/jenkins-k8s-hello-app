# hello-app (Jenkins & k8s)

## Add Docker Hub Auth
```
kubectl create secret docker-registry docker-auth-config --docker-server=index.docker.io --namespace=jenkins --docker-username=USERNAME --docker-password=PASSWORD
```
