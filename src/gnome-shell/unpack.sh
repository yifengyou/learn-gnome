#!/bin/bash

workdir=`pwd`

echo '<?xml version="1.0" encoding="UTF-8"?>' > $workdir/gnome-shell-theme.gresource.xml
echo """<gresources>
<gresource prefix="/org/gnome/shell/theme">""" >> $workdir/gnome-shell-theme.gresource.xml
cp /usr/share/gnome-shell/gnome-shell-theme.gresource /usr/share/gnome-shell/gnome-shell-theme.gresourcae.back

for r in `gresource list /usr/share/gnome-shell/gnome-shell-theme.gresource`; do
	gfile="${r#\/org\/gnome\/shell\/theme/}";
	mkdir -p "$(dirname $workdir/theme/$gfile)"

	if [ "$gfile" != "wallpaper-gdm.png" ]; then
		gresource extract /usr/share/gnome-shell/gnome-shell-theme.gresource $r >$workdir/theme/$gfile
		echo "<file>$gfile</file>" >> $workdir/gnome-shell-theme.gresource.xml
	fi
done


echo """	</gresource>
</gresources>
""" >> $workdir/gnome-shell-theme.gresource.xml

#gs="/usr/share/gnome-shell/gnome-shell-theme.gresource"
#for r in `gresource list $gs`; do
#	gresource extract $gs $r > theme/${r##*/}
#done
