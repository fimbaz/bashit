#!/bin/bash
DIR=/usr/local/bin/
mkdir -p ~/.bashit
rm -f ~/.bashit/comm ~/.bashit/cmd
mkfifo ~/.bashit/cmd ~/.bashit/comm
stty -echo raw
set +e
cat -u ~/.bashit/comm | ssh -tt "$@" $(cat $DIR/prompt_command.bash) bash -i | \
    tee >( exec 3<> ~/.bashit/cmd;
           while read CMD; do
               [[ $CMD =~ \(\(MBHIST\)\)(.*)\(\(MBHISTEND\)\) ]]
               if [[  ${BASH_REMATCH[1]} != "" ]]; then
                   echo ${BASH_REMATCH[1]} >> ~/.bash_universal_history
               fi
               [[ $CMD =~ \(\(MBCMD\)\)(.*)\(\(MBCMDEND\)\) ]]
               if [[  ${BASH_REMATCH[1]} != "" ]]; then
                   echo $(eval ${BASH_REMATCH[1]}) >&3
               fi
           done)&
#tee >($DIR/bashit >> $HOME/.bash_universal_history)&
bash -c "cat - < ~/.bashit/cmd | bash | > ~/.bashit/comm"&
cat -u - < /dev/stdin > ~/.bashit/comm
reset
