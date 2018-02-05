#!/bin/bash

## globals ##
BASE="osrf/ros"
REPO="lfdebrux/ros"
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# -lt 1 ]; then
	echo "Usage: [-g] $0 TAG..."
	exit 1
fi

# option flags
GENERATE_ONLY=false

function create_dockerfile() {
	local BUILD_DIR="$SRC_DIR/$TAG"

	mkdir -p "$BUILD_DIR"
	cp "$SRC_DIR/catkin_entrypoint.sh" "$BUILD_DIR"

	# construct the dockerfile
	echo "FROM $BASE:$TAG" > "$BUILD_DIR/Dockerfile"
	cat "$SRC_DIR/Dockerfile.fragment" >> "$BUILD_DIR/Dockerfile"
}

function build_image() {
	docker pull "$BASE:$TAG"

	docker build "$BUILD_DIR" --tag "$REPO:$TAG"
}

# read option flags
while getopts ":g" opt; do
	case $opt in
		g)
			GENERATE_ONLY=true
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
	esac
done

# pop option arguments off $@
shift $((OPTIND -1))

# for_each $@
for TAG; do
	if $GENERATE_ONLY; then
		echo "generating $REPO:$TAG"
		create_dockerfile
	else
		echo "building $REPO:$TAG"
		create_dockerfile
		build_image
	fi
done
