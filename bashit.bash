#!/bin/bash
DIR=/usr/local/bin/
mkdir -p ~/.bashit
rm -f ~/.bashit/comm ~/.bashit/cmd
mkfifo ~/.bashit/cmd ~/.bashit/comm
stty -echo raw
set +e
cat -u ~/.bashit/comm | ssh -tt "$@" $(cat $DIR/prompt_command.bash) bash -i | \
    tee >( exec 3<> ~/.bashit/comm;
           while read CMD; do
               if [[ $CMD =~ \(\(MBHIST\)\)(.*)\(\(MBHISTEND\)\) ]]; then
                   echo ${BASH_REMATCH[1]} >> ~/.bash_universal_history
               fi
               if [[ $CMD =~ \(\(MBCMD\)\)(.*)\(\(MBCMDEND\)\) ]]; then
                   MATCH="${BASH_REMATCH[1]}"
                   echo " openssl enc -base64 -d <<< $(openssl enc -base64 <<< $($MATCH))"  >&3
               fi
           done)&
#tee >($DIR/bashit >> $HOME/.bash_universal_history)&
cat -u - < /dev/stdin > ~/.bashit/comm
reset
