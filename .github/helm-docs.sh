#!/bin/bash
set -euo pipefail

HELM_DOCS_VERSION="1.11.0"

# install helm-docs if needed

if ! helm_docs="$(which helm-docs 2>/dev/null)"; then
  curl --silent --show-error --fail --location \
    https://github.com/norwoodj/helm-docs/releases/download/v"${HELM_DOCS_VERSION}"/helm-docs_"${HELM_DOCS_VERSION}"_Linux_x86_64.tar.gz \
  | tar xz helm-docs
  chmod +x helm-docs
  helm_docs="${PWD}/helm-docs"
fi

# validate docs (Generate "gold standard", then compare against pushed version)
$helm_docs --log-level error --sort-values-order file --document-dependency-values
if find . -name README.md -execdir git diff --stat --exit-code -- '{}' \+; then
  echo "Helm docs linting passed"
else
  echo "ERROR: Helm docs linting failed. Re-run helm-docs before committing."
  exit 1
fi
