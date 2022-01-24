
SHELL = /bin/bash
TAG ?= latest

all: build

build:
	docker build --tag russellhoff/gdal-base:$(TAG) --file Dockerfile .
	docker tag russellhoff/gdal-base:$(TAG) russellhoff/gdal-base:latest

test:
	# TODO fix https://api.travis-ci.com/v3/job/166029093/log.txt
	# # Test image inheritance and multistage builds
	# # Problem: Dockerfile should be FROM ???, need to build against TAG from the build step
	# cd tests && docker build --tag test-gdal-base-multistage --file Dockerfile.test .
	# docker run --rm \
	# 	--volume $(shell pwd)/:/app \
	# 	test-gdal-base-multistage \
	# 	/app/tests/run_multistage_tests.sh
	# Test GDAL CLI, etc on the base image itself
	docker run --rm \
		--volume $(shell pwd)/:/app \
		russellhoff/gdal-base:$(TAG) \
		/app/tests/run_tests.sh

shell: build
	docker run --rm -it \
		--volume $(shell pwd)/:/app \
		russellhoff/gdal-base:$(TAG) \
		/bin/bash
