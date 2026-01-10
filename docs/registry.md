Run `kubectl get svc -n default registry-service` to get the NodePort port number.
```
NAME               TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
registry-service   NodePort   10.43.89.49   <none>        5000:31033/TCP   20m
```

Pick any node in the cluster and find its Tailscale IP. 

To get a catalog of images in the registry, use `curl http://<tailscale-ip>:<port>/v2/_catalog`

If we want to push images using Docker, need to add a line in `Settings → Docker Engine`
```
{
  "insecure-registries": ["<tailscale-ip>:<port>"]
}
```

NodePort port may change if the service is re-created. This happens if we uninstall, force upgrade, or delete. Try to use rolling updates where possible.