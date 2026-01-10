To access Dashboard run:
```
  kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
```

NOTE: In case port-forward command does not work, make sure that kong service name is correct.
      Check the services in Kubernetes Dashboard namespace using:
        `kubectl -n kubernetes-dashboard get svc`

Dashboard will be available at:
  `https://localhost:8443`

Create a token with
```
kubectl -n kubernetes-dashboard create token admin
```

Service account is defined in `/kubernetes/dashboard-admin.yaml`. 
```
kubectl apply -f kubernetes/dashboard-admin.yaml
```

TODO: add certificate so pods can pull from registry.