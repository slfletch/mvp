# GitHub

A collection of tasks to help working with the [GitHub
API](https://developer.github.com/v3/).

## GitHub token

Most tasks would expect to have a secret set in the kubernetes secret `github`
with a GitHub token in the key `token`, you can easily create it on the
command line with `kubectl` like this :

```
kubectl create secret generic github --from-literal token="MY_TOKEN"
```


## Add a comment to an issue or a pull request

The `github-add-comment` task let you add a comment to a pull request or an
issue.

### Install the Task

```
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/github-add-comment/0.1/github-add-comment.yaml
```

### Parameters

* **GITHUB_HOST_URL:**: The GitHub host domain (_default:_ `api.github.com`)
* **API_PATH_PREFIX:**: The GitHub Enterprise has a prefix for the API path. _e.g:_ `/api/v3`
* **REQUEST_URL:**: The GitHub pull request or issue url, _e.g:_
  `https://github.com/tektoncd/catalog/issues/46`
* **COMMENT:**: The actual comment to add _e.g:_ `don't forget to eat your vegetables before commiting.`.

## Usage

This TaskRun add a comment to an issue.

```yaml
---
apiVersion: tekton.dev/v1beta1
kind: TaskRun
metadata:
  labels:
    tekton.dev/task: github-add-comment
  name: github-add-comment-to-pr-22
spec:
  taskRef:
    kind: Task
    name: github-add-comment
  params:
    - name: REQUEST_URL
      value: https://github.com/chmouel/scratchpad/pull/46
    - name: COMMENT
      value: |
          The cat went here and there
          And the moon spun round like a top,
          And the nearest kin of the moon,
          The creeping cat, looked up.
          Black Minnaloushe stared at the moon,
          For, wander and wail as he would,
          The pure cold light in the sky
          Troubled his animal blood.
```
