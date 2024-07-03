#!/usr/bin/env bash
####################
set -e
####################
readonly IMAGE_NAME="bookworm-golang"
####################
build(){
	podman build -f Containerfile --tag="${IMAGE_NAME}"
}
####################
case ${1} in
	build) build ;;
	*) printf 'usage: < build | help >\n' 1>&2; exit 1 ;;
esac

