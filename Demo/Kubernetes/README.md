# <center>Kubernetes Overview![image](./kubernetes.svg)</center> 
Kubernetes (K8) is a container orchestration service used to automate the deployment, scaling, and management of containerized applications. In the examples directory, there are sample yaml files for different objects such as Deployment, Pods, ReplicaSets, etc.

## Kubectl
Here are some useful commands for the kubectl:
```
kubectl apply -f <FILENAME>.yaml
```
```
kubectl create -f <FILENAME>.yml
```
```
kubectl scale replicas=<UPDATED_NUMBER> -f <FILENAME>.yml
// Or the command below (need to update number in )
kubectl replace -f <FILENAME>.yml
```
## Deployment
In a production environment, a deployment object in K8 can help deploy and manage the running pods instances.
