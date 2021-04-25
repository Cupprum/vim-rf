BASE_NAME            = vim_base
BASE_VERSION        ?= 0.1.0
BASE_TAG             = vimrobotframework/$(BASE_NAME):$(BASE_VERSION)
TEST_NAME            = vim_base_syntax_test
TEST_VERSION        ?= 0.1.0
TEST_TAG             = vimrobotframework/$(TEST_NAME):$(TEST_VERSION)
PLUGIN_NAME          = vim_rf
PLUGIN_VERSION      ?= 0.1.0
PLUGIN_TAG           = vimrobotframework/$(PLUGIN_NAME):$(PLUGIN_VERSION)

.PHONY: docker-build-base docker-run-base docker-build-run-base docker-clean-base \
	docker-build-test docker-run-test docker-build-run-test docker-clean-test \
	docker-build docker-run docker-build-run docker-clean \
	docker-clean-all

docker-build-base:
	docker build --rm -t $(BASE_TAG) -f "Dockerfile-vim-base" .

docker-run-base:
	docker run --rm -it $(BASE_TAG) bash

docker-build-run-base: docker-build-base docker-run-base

docker-clean-base:
	docker rmi -f `docker images -q $(BASE_TAG)` || true

docker-build-test:
	docker build --rm -t $(TEST_TAG) -f "Dockerfile-vim-syntax-test" .

docker-run-test:
	docker run --rm -it $(TEST_TAG) bash

docker-build-run-test: docker-build-test docker-run-test

docker-clean-test:
	docker rmi -f `docker images -q $(TEST_TAG)` || true

docker-build:
	docker build --rm -t $(PLUGIN_TAG) -f "Dockerfile-vim-robotframework" .

docker-run:
	docker run --rm -it $(PLUGIN_TAG) bash

docker-build-run: docker-build docker-run

docker-clean:
	docker rmi -f `docker images -q $(PLUGIN_TAG)` || true

docker-clean-all: docker-clean-base docker-clean-test docker-clean
