#!/usr/bin/bash
#set -e

LOGLEVEL=1

function logme () {
	if [[ $LOGLEVEL > 0 ]];then
		echo "LOG: $1"
	fi
}

repodir=$(dirname $(realpath -s $0))
logme "repo directory is: ${repodir}"

shellname=$(basename $SHELL)
logme "shell is: ${shellname}"

targetdir=~/.local/bin/shell
logme "target directory is: $targetdir"
mkdir -p $targetdir

pathappend=
for srcdir in common $shellname;do
	logme "Copying $srcdir scripts to $targetdir"
	cp -rf $repodir/$srcdir $targetdir
	pathappend="$targetdir/$(basename $srcdir):$pathappend"
done

echo "Copy done. Need to append to path variable: ${pathappend}"
echo -n "Add path append to ${shellname}rc? [y/n] "
read inp
if [ "$inp" = "y" ];then
	cmd="PATH=${pathappend}"\$"PATH"
	rcfile=~/.${shellname}rc
	logme "Appending command to $rcfile: "\""$cmd"\"
	echo $cmd >> $rcfile
fi
