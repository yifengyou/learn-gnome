# Ubuntu 18.04

## gnome-shell.css

GNOME 3.12 开始使用 GResource 二进制资源文件保存 js/css/svg 等文件，需使用 gresource 解压，使用 glib-compile-resources 封装。
将下面的代码保存为一个sh脚本文件：
```
#!/bin/bash
gs="/usr/share/gnome-shell/gnome-shell-theme.gresource"
for r in `gresource list $gs`; do
    gresource extract $gs $r > theme/${r##*/}
done
```

修改样式

执行上面的脚本后，主题就解压到当前目录下theme文档夹里面，里面包含了一些图片和更改样式需要的gnome-shell.css这个样式表文档。通过修改样式表文档就可以达到任何你想要的效果。

使用 glib-compile-resources重新封装，新建脚本文档zip.sh，执行该脚本，代码如下：

```
cd ./theme
glib-compile-resources --target ../gnome-shell-theme.gresource gnome-shell-theme.gresource.xml
```
替换主题文档


运行这个脚本文件就会在当前目录下生成gnome-shell-theme.gresource中编译打包过了的资源文件，其中就有gnome-shell.css
接着按你所需编辑gnome-shell.css文件后，在终端执行以下命令：

//这是是下载gnome-shell-theme.gresource.xml资源规格文件到当前目录
```
curl https://raw.githubusercontent.com/GNOME/gnome-shell/master/data/gnome-shell-theme.gresource.xml > gnome-shell-theme.gresource.xml
```
接着执行编译命令来生成资源文件：

```
glib-compile-resources gnome-shell-theme.gresource.xml
```

执行完毕后就回在当前目录生成gnome-shell-theme.gresource文件了。
将生成的gnome-shell-theme.gresource 覆盖系统默认的 /usr/share/gnome-shell/gnome-shell-theme.gresource 即可。


### unpack.sh

```
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

```

### pack.sh

```

```



## css样式

https://forum.ubuntu.org.cn/viewtopic.php?f=94&t=349068


## 参考

* <https://forum.ubuntu.org.cn/viewtopic.php?f=94&t=349068>


---
