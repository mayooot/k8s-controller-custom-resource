# Kubernetes Custom Controller - Custom Resource Handling

**Note**: the source code is _verbosely_ commented, so the source is meant to be read and to teach

## What has changed？
I changed [network.yaml](crd/network.yaml) and [example.yaml](example/example-network.yaml), when you use `k8s.io` or `kubernetes.io`,
there will be an error because `k8s.io` or `kubernetes.io` is protected.

```
The CustomResourceDefinition "networks.samplecrd.k8s.io" is invalid: metadata.annotations[api-approved.kubernetes.io]: Required value: protected groups must have approval annotation "api-approved.kubernetes.io", see https://github.com/kubernetes/enhancements/pull/1111
```

So I referred to the official document of k8s crd and changed there.
When you changed from `samplecrd.k8s.io` to `samplecrd.sample.com`, your controller is still list and watch `samplecrd.k8s.io`,
so you need to change the annotation in the code and regenerate the code.

I used go module, so you don't have to put your code in $GOPATH,
you can use `make build` to generate the linux amd version of the executable file.  

## What is this?

An example of a custom Kubernetes controller that's only purpose is to watch for the creation, updating, or deletion of all custom resource of type `Network` (in the all namespaces). This was created as an exercise to understand how Kubernetes controllers work and interact with the cluster and resources.

## Running

Clone repo:

```
$ git clone https://github.com/resouer/k8s-controller-custom-resource
$ cd k8s-controller-custom-resource
```

Prepare build environment:

```
$ go get github.com/tools/godep
$ godep restore
```

Build and run:

```
$ go build -o samplecrd-controller .
$ ./samplecrd-controller -kubeconfig=$HOME/.kube/config -alsologtostderr=true
```

You can also use `samplecrd-controller` to create a Deployment and run it in Kubernetes. Note in this case, you don't need to specify `-kubeconfig` in CMD as default `InClusterConfig` will be used.

## Usage

You should create the CRD of Network first:

```
$ kubectl apply -f crd/network.yaml
```

You can then trigger an event by creating a Network API instance:

```
$ kubectl apply -f example/example-network.yaml
```

CURD the Network API instance, and check the logs of controller. 

Enjoy!
