#!/usr/bin/env bash
####################
set -e
####################
readonly AMD64=https://go.dev/dl/go1.22.4.linux-amd64.tar.gz
readonly AMD64_HASH=ba79d4526102575196273416239cca418a651e049c2b099f3159db85e7bade7d
readonly ARM64=https://go.dev/dl/go1.22.4.linux-arm64.tar.gz
readonly ARM64_HASH=a8e177c354d2e4a1b61020aca3562e27ea3e8f8247eca3170e3fa1e0c2f9e771
####################
eprintln(){
  local msg="${1}"
  if [ -z "${msg}" ]; then printf 'undefined err msg\n' 1>&2; exit 1; fi
  printf "${msg}\n" 1>&2; return 1
}
install_multi(){
  case $(arch) in
    x86_64) install ${AMD64} ${AMD64_HASH} ;;
    aarch64) install ${ARM64} ${ARM64_HASH};;
    *) eprintln "unsupported arch: $(arch)";;
  esac
}
install(){
  wget ${1} -O /tmp/go.tar.gz
  if [ "${2}" != "$(sha256sum /tmp/go.tar.gz | awk '{print $1}')" ]; then
    eprintln "go checksum does not match"
  fi
  mkdir -p /root/.local/share/go
  mkdir -p /root/.local/go
	cd /root/.local
  tar -xvf /tmp/go.tar.gz
  rm -rf /tmp/go.tar.gz
	if ! which go 1>/dev/null 2>&1; then
		printf "ERROR, go not in path" 1>&1
		return 1
	fi
}
####################
install_multi
