PROMPT_COMMAND='X="((MBHIST))$(history 1)((MBHISTEND))";SPACES="$(printf %${#X}s)";BSES=$(printf %${#X}s |'" tr ' ' $'\b');"'echo -n "${X}"; echo -ne "${BSES}${SPACES}${BSES}"; echo -ne "\n\033[1A"'
