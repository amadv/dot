Kind works for me very well at least for development and testing.

https://kind.sigs.k8s.io/ 35

Also has a driver to use podman (rootless) as container runtime (experimental).

Be sure to enable iptables modules, first, all of them. more info here:
https://kind.sigs.k8s.io/docs/user/rootless/ 23

* Create /etc/modules-load.d/iptables.conf with the following content:
```
ip6_tables
ip6table_nat
ip_tables
iptable_nat
```
* Add flag $ KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster
  * `vi .bashrc`
  * `export KIND_EXPERIMENTAL_PROVIDER=podman`
  * `source ~/.bashrc`

And also if you have BTRFS enabled, you have to create a custom cluster-config.yaml in order to mount the host volume to the nodes, else will fail on creation.

More info here: kind doesn't work on btrfs · Issue #1416 · kubernetes-sigs/kind · GitHub 8

Here my configuration for a single node cluster called development:

cluster-config.yaml
```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: development
networking:
nodes:
- role: control-plane
  # https://github.com/kubernetes-sigs/kind/issues/1416#issuecomment-600438973
  # https://kind.sigs.k8s.io/docs/user/configuration/#extra-mounts	  
  kubeadmConfigPatches:
  - |
    kind: JoinConfiguration
  # To enable Ingress this port-mapping is required
  # https://kind.sigs.k8s.io/docs/user/configuration/#extra-port-mappings
  extraPortMappings:  
  - containerPort: 80 
    hostPort: 8080
    protocol: TCP
  - containerPort: 443
    hostPort: 4443
    protocol: TCP
  extraMounts:
    - hostPath: /dev/nvme0n1p3
      containerPath: /dev/nvme0n1p3
      propagation: HostToContainer
```

Then create the cluster with your cluster-config.yaml file:

`kind create cluster --config=cluster-config.yaml`

That should do it :sparkles:

ps. What’s best: you don’t need to install any additional stuff to get your cluster up and running, just the kind binary and that’s it. no rpm-ostree, no nothing… :eyes:
