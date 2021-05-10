.PHONY: test-ubuntu_20_04
test-ubuntu_20_04: ## Test on ubuntu:20.04
	docker build -t dpi_test-ubuntu_20.04 --file tests/env/Ubuntu_20.04.Dockerfile tests/env
	docker run -it -v "${PWD}":/home/root/.default_program_installer \
	-w /home/root/.default_program_installer \
	dpi_test-ubuntu_20.04 \
	/bin/bash -c "./default_install.sh"

.PHONY: help
help: ## Display this help message
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
