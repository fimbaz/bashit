PROMPT_COMMAND='X=$(history 1 | tr n " ");SPACES=$(printf %${#X}s);BSES=$(printf %${#X}s |'" tr ' ' $'\b');"'echo -n $(history 1 |'" tr $'\n' ' ')"


#BSES=$(printf %${#X}s | tr ' ' $'\b')"
#|"tr ' ' $'\b');
#"'SPACES=$(printf %${#X}s;); echo"' "$BSES" $SPACES" "$BSES"'