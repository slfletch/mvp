# Conftest

These tasks make it possible to use [Conftest](https://github.com/instrumenta/conftest) within
your Tekton pipelines. Conftest is a tool for testing configuration files using [Open Policy Agent](https://openpolicyagent.org).

## Installation

Conftest also has a Helm plugin, which redners the Helm chart before applying the policy. For that task use:

```console
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/helm-conftest/0.1/helm-conftest.yaml
```

## Helm usage


Once installed, the Helm task can be used as follows:

```yaml
apiVersion: tekton.dev/v1beta1
kind: TaskRun
metadata:
  name: helm-conftest-example
spec:
  taskRef:
    name: helm-conftest
  workspaces:
  - name: source
    persistentVolumeClaim:
      claimName: my-source
  params:
  - name: chart
    value: stable/mysql
  - name: policy
    value: stable/mysql/policy
```

## Parameters

* **chart**: The chart to test against the specified policies (_default:_ `.`)
* **policy**: Where to find the policies (_default:_ `policy`)
* **output**: Which output format to use (_default:_ `stdout`)
* **args**: An array of additional arguments to pass to Conftest (_default `[]`)

## Workspaces

* **source**: A [Workspace](https://github.com/tektoncd/pipeline/blob/master/docs/workspaces.md) containing the source to build.
