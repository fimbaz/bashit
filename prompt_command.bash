PROMPT_COMMAND='X="((MBHIST))$(history 1)((MBHIST))";SPACES="$(printf %${#X}s)";BSES=$(printf %${#X}s |'" tr ' ' $'\b');"'echo -n "${X}"; echo -n "${BSES}${SPACES}${BSES}"'
#'echo -n "${BSES}${SPACES}${BSES};"'

#PROMPT_COMMAND='X=$(history 1 | tr n " ");SPACES=$(printf %${#X}s);BSES=$(printf %${#X}s |'" tr ' ' $'\b');"'echo -n $(history 1 |'" tr $'\n' ' ')"


#BSES=$(printf %${#X}s | tr ' ' $'\b')"
#|"tr ' ' $'\b');
#"'SPACES=$(printf %${#X}s;); echo"' "$BSES" $SPACES" "$BSES"'
