#!/bin/bash

if ! which glib-compile-resources; then
	sudo apt-get install -y libglib2.0-dev-bin
fi
cd ./theme
glib-compile-resources --target ../gnome-shell-theme.gresource-new ../gnome-shell-theme.gresource.xml
