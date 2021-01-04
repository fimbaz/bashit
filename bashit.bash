#!/bin/bash
DIR=/usr/local/bin/
mkdir -p ~/.bashit
rm -f ~/.bashit/comm ~/.bashit/cmd
mkfifo ~/.bashit/cmd ~/.bashit/comm
stty -echo raw
set +e
cat -u ~/.bashit/comm | ssh -tt "$@" $(cat $DIR/prompt_command.bash) bash -i | tee >($DIR/bashit >> $HOME/.bash_universal_history)&
bash -c "cat - < ~/.bashit/cmd | bash | > ~/.bashit/comm"&
cat -u - < /dev/stdin > ~/.bashit/comm
reset
