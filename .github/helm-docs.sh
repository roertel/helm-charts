#!/bin/bash
set -euo pipefail

HELM_DOCS_VERSION="1.11.0"
PATH=${PATH}:.

# install helm-docs
if ! which helm-docs 2>/dev/null; then
  curl --silent --show-error --fail --location \
    https://github.com/norwoodj/helm-docs/releases/download/v"${HELM_DOCS_VERSION}"/helm-docs_"${HELM_DOCS_VERSION}"_Linux_x86_64.tar.gz \
  | tar x helm-docs
fi

# validate docs (Generate "gold standard", then compare against pushed version)
helm-docs --log-level error --sort-values-order file --document-dependency-values
if find . -name README.md -print0 | xargs --null git diff --stat --exit-code; then
  echo "Helm docs linting passed"
else
  echo "ERROR: Run helm-docs linting failed. Re-run helm-docs before committing."
  exit 1
fi
