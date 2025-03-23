.PHONY: all docker
IMAGE=xiexianbin/openresty:1.25.3.2-3-noble

help:  ## Show this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: docker  ## Build all
docker:  ## build for current os
	docker build . -t $(IMAGE)
