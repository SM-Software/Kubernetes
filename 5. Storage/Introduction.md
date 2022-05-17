## Storage in Kubernetes

- Storage in kubernetes is majorly used where we want to store the data related to pod and exchange the data between the pods.
- Ofcource you can use DB for those cases, but if there is certainly you don't want to store in the databases we can use the volumes.
- So a volume can be used to hold data and state for pods and containers.

### Volumes in K8
- Pods often live and dies so their file system is short
- volumes can be used to store state / data and use it in a pod. A pod can have multipl evolumes attached to it
- Containers relies on a mountPath ro access the volumes
- Kubernetes supports below storage templates:
i) StorageClasses
ii) Volumes
iii) PersistentVolumes
iv) PersistentVolumeClaims

### Volumes in Kubernetes
- A volume references a storage location
- It must have a unique name
- Attached to a pod and may or may not be tied to the pod's lifetime (depending on the volume type)
- A volume Mount references a volume by name and defines a mountPath

#### types of volumes
#### emptyDir
- Empty directory for storing "transient" data (shares a pod's lifetime) useful for sharing files between containers running in a pod.
- See yaml file on implementing the emptyDir volume

#### hostPath: 
- pod mounts into the node's filesystem. it is tied to the node's lifetime. 
- We can use the host file volume as defined in the [yaml-manifest](./yaml-manifest/volume.hostPath.yml)

- The problem with hostPath volume is that if the node is deleted for some reason than the files will be permanently deleted.

- To resolve this kind of issue we can use the cloud file services, ex: Azure File

To know how to set up the environemtn for using Azure File in AKS refer the [link](https://docs.microsoft.com/en-us/azure/aks/azure-files-volume)

- Check the yml manifest [here](./yaml-manifest/volume.azureFile.yml)

#### nfs
- A NFS (Network File System) share mounted into the pod. This is stored somewhere on the network

#### configMap/secret
- Special types of volumes where we can store the secrets and key value pair, which pods can access with kubernetes resources

#### persistentVolumeClaim
- provides pods witha more persistent storage options that is abstracted form the details.

#### Cloud: clsuter-wide storage
- [Azure file share](https://docs.microsoft.com/en-us/azure/aks/azure-files-volume)


### View volume on pod
```
kubectl describe pod [pod-name]
or
kubectl get pod [pod-name] -o yaml
```