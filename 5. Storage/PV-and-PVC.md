## Persistent Volume and Persistent Volume Claim

### Persistent Volume(PV) & Persistent Volume Clain
- Persistent volume is a cluster wide storage unit provisioned by an adminitrator with a lifecycle independent from a pod and it relies on network attached storage.
- It is normally provisioned by the cluster administrator.
- PV is available for the pod even if it gets rescheduled. as it relies on the storage provider such as NFS, cloud storage, etc.
- PV is attached to the pod using PVC.
- A persistentVolume Claim is a request for a storage unit.

### Create PV
- Create a secret for azure file share and remember the secret name
```
kubectl create secret generic <secret_name>
        --from-literal=azurestorageaccountname=<strorage_account_name>
        --from-literal=azurestorageaccountkey=<account_key_for_storage>
```

- create the yaml file
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: static_file_share_pv
spec:
  capacity:
    storage: 5Gi
  accessMode:
    - ReadWriteMany
  azureFile: 
    secretName: <paste the secret name created above>
    shareName: <file Share Name>
    readOnly: false
  mountOptions:
  - dir_mode=0777
  - file_mdoe=0777
  - uid=0
  - gid=0
  - mfsymlinks
  - cache=strict
  - actimeo=30

```
### Create PVC
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure_file_share_pvc
spec:
  resources:
    requests:
      storage: 50Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  storageClassName: "" # Leaving the storage class name as blank means we are statically binding the PV

```
### Bind pod to PVC
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx_pod
  labels:
    name: nginx_pod
spec:
  containers:
  - name: nginx_pod
    image: nginx:alpine
    resources:
      limits:
        memory: "128Mi"
        cpu: "500m"
    ports:
      - containerPort: 3308
    volumeMounts:
      - name: blobDisk01
        mountPath: /mnt/blobdisk
    volumes:
    - name: blobDisk01
      persistentVolumeClaim:
        claimName: azure_file_share_pvc
```