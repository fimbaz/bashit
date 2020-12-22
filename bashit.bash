#!/bin/bash
DIR=/usr/local/bin/
ssh -t "$@" $(cat $DIR/prompt_command.bash) bash | tee >($DIR/bashit >> $HOME/.bash_universal_history)
