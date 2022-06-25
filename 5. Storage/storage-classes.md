## Storage classes

### What are they and what are the advantges of having a Storage Class
- It is used to define the class of storages
- it acts as a type of storage template
- USing Storage classes we can provision the persistent volumes dynamically.

### Process of creating the PV with Storage.
1. Create a storage Class (yml file with the storage class definition)
2. Create the PVC that references the Storage class
3. kubernetes uses the Storage Class provisioner to provision a PersistentVolume
4. Storage is provisioned, persistent volume will be created and bound to the Persistent Volume Claim.
5. Pod volume references PVC.

### Storage Class

- below is the yaml manifest

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: azure_file_share_sc # name of the storage class that will be used to link the PVC to the SC
provisioner: kubernetes.io/azure-file
mountOptions:
  - dir_mode=0777
  - file_mdoe=0777
  - uid=0
  - gid=0
  - mfsymlinks
  - cache=strict
  - actimeo=30
parameters:
  skuName: standard_LRS # Storage sku to be used
  shareName: pod_aks_file_share # Name of the file share to be created
```

### PVC for Storage Class
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure_file_share_pvc
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: azure_file_share_sc 
  resource:
    requests:
      storage: 5Gi
```

### pod for consuming the PVC
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx_with_dynamic_provisioning
  labels:
    name: dynamic_azure_file
spec:
  containers:
  - name: pod_for_file_share
    image: nginx:alpine
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        memory: "256Mi"
        cpu: "250m"
    volumeMounts:
      - mountPath: "mnt/azure"
        name: azure_file_share_vol
    volumes:
      - name: azure_file_share_vol
        persistentVolumeClaim:
          claimName: azure_file_share_pvc

```

### Adding a file to File share via pod
- Deploy the SC PVC and pod uisng the kubectl
```
kubectl apply -f sc.azurefile.yml
kubectl apply -f pvc.azurefile.yml
kubectl apply -f pod.pvc.yml
```

- Log into the pod using below command
```
kubectl exec pod/<pod_name> -it -- /bin/sh
```
- add the file to the file share mounted path
```
echo "Hello from pod. Azure file share file" > /mnt/azure/myfile.txt
```

- verify a file creates successfully
```
ls /mnt/azure
```

- verify the content of the file
```
cat /mnt/azure/myfile.txt
```

- Verify the file content from azure portal in the file share

