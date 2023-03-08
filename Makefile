makefile_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
root_branch != git -C "$(makefile_dir)" symbolic-ref refs/remotes/origin/HEAD | sed 's@^.*/@@'

lint:
#	Regenerate docs
	helm-docs --log-level error --sort-values-order file --document-dependency-values

# 	Lint chart
	docker run --rm --tty --volume $(makefile_dir):/data --workdir=/data \
		quay.io/helmpack/chart-testing ct lint \
		--config /data/.github/ct.yaml --target-branch '$(root_branch)'

#	Generate and score manifests
	docker run --rm --tty --volume $(makefile_dir):/project --entrypoint /bin/sh \
		zegl/kube-score -c "find /project/charts \
		-mindepth 1 -maxdepth 1 -type d -exec helm template '{}' --generate-name \; \
		| kube-score score --ignore-test container-resources \
		--ignore-test container-image-pull-policy,pod-networkpolicy \
		--ignore-test container-ephemeral-storage-request-and-limit -"

#	Scan code repository for vulnerabilities
	docker run --rm --tty --volume $(makefile_dir):/src \
		docker.io/aquasec/trivy --config /src/.github/trivy.yaml fs /src

clean:
	
distclean:
	docker rmi quay.io/helmpack/chart-testing docker.io/zegl/kube-score
