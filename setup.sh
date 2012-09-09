#!/bin/sh
if [ -z $HOME ]; then
	echo "\$HOME not set"
	exit 1
fi

ROOT="$(pwd)/$(dirname $0)"
for file in $(find $ROOT -type f -depth 1 -name ".*"); do
	link="$HOME/$(basename $file)"
	if [ -e $link ]; then
		if [[ -h $link && $(readlink $link) -ef $file ]]; then
			echo "$file already linked"
			continue
		fi
		while true; do
			echo "Replace old $link? Y(es)/n(o)/c(at))/q(uit)"
			ls -la $link
			read decision
			case $decision in
			"Y")
				rm $link
				ln -s $file $link
				;;
			"n")
				echo "Did nothing"
				;;
			"c")
				cat $link
				continue
				;;
			"q")
				exit 0
				;;
			*)
				continue
				;;
			esac
			break
		done
	else
		echo "Creating link $link -> $file"
		ln -s $file $link
	fi
done
