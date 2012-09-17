#!/bin/sh
if [ -z $HOME ]; then
  echo "\$HOME not set"
  exit 1
fi

# Touch this file to track when last time asked for update
TOUCHED=$(stat -f "%m" $0)
NOW=$(date +%s)
DIFF=$(expr $NOW - $TOUCHED)

# Check updates every 3 days (259200 seconds)
if [ $DIFF -gt 259200 ]; then
  while true; do
    echo "Pull updates? Y(es)/n(o)"
    read decision
    case $decision in
    "Y")
      pushd $(dirname $0) &> /dev/null
      echo "Pull in $(pwd)"
      git pull
      popd &> /dev/null
      break
      ;;
    "n")
      break
      ;;
    *)
      continue
      ;;
    esac
  done
  touch $0
fi

# Link automatically all dotfiles, prompt if existing file found that would be
# replaced by the link
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
