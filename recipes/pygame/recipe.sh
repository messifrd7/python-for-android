#!/bin/bash

PRIORITY_pygame=21
VERSION_pygame=1.9.1
URL_pygame=http://pygame.org/ftp/pygame-$(echo $VERSION_pygame)release.tar.gz
DEPS_pygame=(sdl)
MD5_pygame=1c4cdc708d17c8250a2d78ef997222fc
BUILD_pygame=$BUILD_PATH/pygame/$(get_directory $URL_pygame)
RECIPE_pygame=$RECIPES_PATH/pygame

function prebuild_pygame() {
true
}

function build_pygame() {
	cd $BUILD_pygame

	push_arm

	CFLAGS="$CFLAGS -I$JNI_PATH/png -I$JNI_PATH/jpeg"
	CFLAGS="$CFLAGS -I$JNI_PATH/sdl/include -I$JNI_PATH/sdl_mixer"
	CFLAGS="$CFLAGS -I$JNI_PATH/sdl_ttf -I$JNI_PATH/sdl_image"
	export CFLAGS="$CFLAGS"
	export LDFLAGS="$LDFLAGS -L$LIBS_PATH -lm -lz"
	try $BUILD_PATH/python-install/bin/python.host setup.py install
	try find build/lib.* -name "*.o" -exec $STRIP {} \;

	pop_arm
}

function postbuild_pygame() {
	true
}