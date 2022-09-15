# Welcome to the contributing guide
This guide describes how to contribute to this repository.

# Contributing

1. Fork of the branch you want to contribute to.
1. Apply your changes to your fork.
1. Document and test your changes.
1. Create a merge request back to this repsitory.
1. Upon approval, your changes will be merged into the same branch you forked. 

# Coding
Make updates to the individual charts using standard Helm tools.

# Linting
Use [Kubeval](//kubeval.com) to lint your Helm-generated manifests. Be sure to validate against several K8s versions, not just the one that you're using. 

Example:
```
KUBEVAL_VERSION="0.16.1"
SCHEMA_LOCATION="https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/main/"

helm template "my_chart" | ./kubeval --strict --ignore-missing-schemas --kubernetes-version "${KUBERNETES_VERSION#v}" --schema-location "${SCHEMA_LOCATION}"
```

# Documenting
Include [helm-docs](//norwoodj/helm-docs) style comments in the values.yaml file. Documentation will be auto-generated. 

# Testing
Execute your tests locally. Be sure to create or update tests in the `templates/tests` directory so that `helm test` works as expected. 

# Building & Deploying
There is an action on the repository, but if you want to build and deploy manually, follow the below steps:

1. Build package(s) in your working branch.
1. Stash the packages.
1. Change to the `gh-pages` branch.
1. Unstash the packages.
1. Build the index.
1. Commit & push.
```
rmdir build
helm package `ls -d */` -d build
git stash push -u build
git checkout gh-pages
git stash pop
mv -u build/* .
rmdir build
helm repo index .
git commit -am "Publish charts"
```
