IMAGE ?=
SRC ?=
REGISTRY_HOST := rpic-1:31033

GEN_TAG := $(shell openssl rand -hex 6)

.PHONY: build

build:
ifndef IMAGE
	$(error IMAGE is required)
endif
ifndef SRC
	$(error SRC is required)
endif
	docker buildx build \
	  --platform linux/arm64 \
	  -t $(REGISTRY_HOST)/$(IMAGE):$(GEN_TAG) \
	  --push \
	  $(SRC)
