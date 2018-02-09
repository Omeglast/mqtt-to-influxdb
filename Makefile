.PHONY: build

# Detect OS to adapt to local user
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	USER:=
else
	UID:=$(shell id -u `whoami`)
	GID:=$(shell id -g `whoami`)
	USER:=--user "$(UID):$(GID)"
endif

GO_CMD=docker run --rm -v `pwd`:/go -w /go $(USER) golang:alpine
BINARY=hello

build:
	$(GO_CMD) sh -c "go get -d ./... && go install -v ${BINARY}"