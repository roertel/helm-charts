makefile_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
root_branch != git -C "$(makefile_dir)" symbolic-ref refs/remotes/origin/HEAD | sed 's@^.*/@@'

lint:
# 	Lint chart
	docker run --rm -itv $(makefile_dir):/data --workdir=/data \
		quay.io/helmpack/chart-testing ct lint --target-branch '$(root_branch)'

#	Lint Helm chart README.md files
	$(makefile_dir).github/helm-docs.sh

#	Generate and score manifests
	docker run --rm -itv $(makefile_dir):/project --entrypoint /bin/sh \
		zegl/kube-score -c "find /project/charts -mindepth 1 -maxdepth 1 \
		-type d -exec helm template '{}' --generate-name \; | kube-score score \
      	--ignore-container-cpu-limit --ignore-container-memory-limit -"

clean:
	
distclean:
	docker rmi quay.io/helmpack/chart-testing docker.io/zegl/kube-score
