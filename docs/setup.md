To administrate the cluster from our computer, we need to copy over `/etc/rancher/k3s/k3s.yaml` from the master node (`rpic-1`) to our local `~/.kube/config`. Contains some certificates and context data.

```
ssh rpic@rpic-1
sudo cat /etc/rancher/k3s/k3s.yaml
```

Copy this into `~/.kube.config`.

Replace `server: https://<ip>:6443` with `server: https://rpic-1.<tailnet-id>.ts.net:6443`. Can get the full Magic DNS name from the Tailscale console.




