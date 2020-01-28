version = 0.0.1
image = imagename
registry = docker.io/guygrigsby
build = $(image):$(version)
test: 
	@go test --race ./... -v

build: 
	@echo "Building $(build)..."
	@docker build --rm=true --no-cache=true --pull=true -t $(build) .
	@docker tag $(build) $(registry)/$(build)

release: build
	@echo "Releasing $(build)..."
	@docker push $(registry)/$(build)

debug: build
	@docker run -it $(registry)/$(build) /bin/sh

.PHONY: build release debug
