#!/bin/bash
DIR=/usr/local/bin/
rm -f ~/comm
mkfifo ~/comm
stty -echo raw
set +e
cat -u ~/comm | ssh -tt "$@" $(cat $DIR/prompt_command.bash) bash -i | tee >($DIR/bashit >> $HOME/.bash_universal_history)&
cat -u - < /dev/stdin > ~/comm
reset
