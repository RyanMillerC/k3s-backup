# hostPath PV Backup

Back up Kubernetes [hostPath] ([local-path-provisioner]) Persistent Volumes
(PVs) by temporarily draining applications Pods, backing up the PV's host
directory to an NFS mount, and restoring the application Pod count.

The playbook *backup-apps.yml* calls the *backup_app* role for every
application specified in *vars.yml*. backup_app calls the *backup_pvc* role for
every PVC mounted to the given app's deployment. Each application Deployment
will have it's Pods temporarily reduced to 0 replicas. This is important so
that databases and other stateful workloads can cleanly write to disk before
the backup is taken. After the backup is complete, the Deployment will be reset
to X number of replica Pods.

I'm running this against a [k3s] cluster in my homelab with
[local-path-provisioner] installed.

## Limitations

* **Only works with [hostPath] PVs!**
* The playbook scales down each deployment one-by-one, meaning temporarily application downtime.

## Usage

### Prereqs

Install kubernetes Python package on k3s host:

```bash
$ sudo /usr/libexec/platform-python -m pip install kubernetes
```

### Running

Initialize the back up:

```bash
$ make
```

You can run this in second terminal window to watch the Pods cycle:

```bash
$ kubectl get pods -A -w
```

[hostPath]: https://kubernetes.io/docs/concepts/storage/volumes/#hostpath
[local-path-provisioner]: https://github.com/rancher/local-path-provisioner
[k3s]: https://k3s.io/
