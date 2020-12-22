#!/bin/bash
DIR=$(dirname "$(readlink -f "$0")")
ssh -t "$@" $(cat $DIR/prompt_command.bash) bash | tee >($DIR/bashit >> $HOME/.bash_universal_history)
