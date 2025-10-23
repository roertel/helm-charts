makefile_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
root_branch != git -C "$(makefile_dir)" symbolic-ref refs/remotes/origin/HEAD | sed 's@^.*/@@'
changed_charts != find '$(makefile_dir)/charts' -mindepth 1 -maxdepth 1 -execdir sh -c "git diff --quiet refs/remotes/origin/HEAD . || echo 'charts/{}'" \;|sort
changed_charts := $(subst /./,/,$(changed_charts))

comma := ,
null := 
space := $(null) #

.PHONY: all clean distclean $(changed_charts)
all: $(changed_charts)

clean:
	rm -rf $(makefile_dir).cache
	rm -rf $(makefile_dir)/charts/*/Chart.lock $(makefile_dir)/charts/*/charts
	
distclean:
	rm -rf $(makefile_dir).cache
	docker rmi \
		quay.io/helmpack/chart-testing \
		docker.io/zegl/kube-score \
		docker.io/ibmcom/helm

$(changed_charts):
	@echo -e '\e[1;33m*\n* Regenerating README.md for $@\n*\e[0m'
	helm-docs --document-dependency-values --log-level error \
		--sort-values-order file --chart-to-generate '$(makefile_dir)$@' 

	@echo -e '\e[1;33m*\n* Linting $@\n*\e[0m'
	docker run --rm --tty --volume $(makefile_dir):/repo --workdir /repo \
		--env "TERM=${TERM}" --env "COLORTERM=${COLORTERM}" \
		quay.io/helmpack/chart-testing ct lint --config .github/ct.yaml \
		--target-branch '$(root_branch)' --check-version-increment \
		--validate-maintainers='$(shell test -L '$@' && echo false || echo true)' --charts '$@'

	@echo -e '\e[1;33m*\n* Generate and score manifests for $@\n*\e[0m'
	docker run --rm --volume $(makefile_dir)$@:/chart --env "TERM=${TERM}" \
		--env "COLORTERM=${COLORTERM}" --tty --entrypoint /bin/sh \
		docker.io/zegl/kube-score -c 'helm template /chart --generate-name \
		--values $(firstword $(wildcard $(makefile_dir)$@/test-values.yaml) \
		/dev/null) | kube-score score \
		--ignore-test container-resources \
		--ignore-test pod-networkpolicy \
		--ignore-test container-image-pull-policy \
		--ignore-test container-ephemeral-storage-request-and-limit -'

	@echo -e '\e[1;33m*\n* Vulnerability scan $@\n*\e[0m'
	mkdir -p $(makefile_dir).cache
	docker run --rm --tty --volume $(makefile_dir):/src \
		--volume $(makefile_dir).cache:/root/.cache \
		--env "TERM=${TERM}" --env "COLORTERM=${COLORTERM}" \
		docker.io/aquasec/trivy --config /src/.github/trivy.yaml fs /src/$@
