#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")/" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Build acceptance test image
pushd "$SCRIPT_DIR/../ci" || exit 1
 docker build -t haproxy-boshrelease-testflight .
popd || exit 1

# Run acceptance tests
docker run --rm --privileged -v "$REPO_DIR":/repo -e REPO_ROOT=/repo haproxy-boshrelease-testflight bash -c "cd /repo/ci/scripts && ./acceptance-tests"
