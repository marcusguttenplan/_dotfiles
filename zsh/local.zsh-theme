# ----------------------------------------------------------------------------
# 1. Dynamic Theme Engine
# ----------------------------------------------------------------------------
setopt PROMPT_SUBST

set_prompt_colors() {

    if [[ "$PWD" == *"/work"* || "$PWD" == *"/aws"* ]]; then
    local theme="blue"
  else
    # Default to the limegreen AEC startup look
    local theme=${TERM_THEME:-green}
  fi

  if [[ "$theme" == "blue" ]]; then
    BASE_COLOR="%B%F{blue}"
    CONTRAST_COLOR="%B%F{yellow}"
  else
    BASE_COLOR="%B%F{118}" # Limegreen
    CONTRAST_COLOR="%B%F{203}" # Red
  fi
  
  INFO_COLOR="%B%F{white}"
  RESET_COLOR="%b%f"
}

# ----------------------------------------------------------------------------
# 2. Horizontal Line Logic with "One-Draw" Gate
# ----------------------------------------------------------------------------
marcus_line_precmd() {
  # If we've already drawn a line for this command cycle, stop.
  [[ "$_MARCUS_LINE_DRAWN" == "true" ]] && return
  
  set_prompt_colors
  print -Pn "$BASE_COLOR"
  print -n "${(r:$COLUMNS::_:)}"
  print -P "$RESET_COLOR"
  
  # Mark as drawn
  _MARCUS_LINE_DRAWN="true"
}

# Reset the gate before every new command is executed
marcus_line_reset() {
  _MARCUS_LINE_DRAWN="false"
}

# ----------------------------------------------------------------------------
# 3. Aggressive Hook Management
# ----------------------------------------------------------------------------
autoload -Uz add-zsh-hook

# Clear any previous versions of our functions
add-zsh-hook -D precmd "marcus_line_precmd"
add-zsh-hook -D preexec "marcus_line_reset"

# Register the drawer and the resetter
add-zsh-hook precmd marcus_line_precmd
add-zsh-hook preexec marcus_line_reset

# ----------------------------------------------------------------------------
# 4. Prompt Construction
# ----------------------------------------------------------------------------
PROMPT='${BASE_COLOR}| ${RESET_COLOR}%~ ${INFO_COLOR}@%m ${BASE_COLOR}(${RESET_COLOR}${CONTRAST_COLOR}%n${RESET_COLOR}${BASE_COLOR}) 
${BASE_COLOR}| => ${RESET_COLOR}'

PS2='${BASE_COLOR}| => ${RESET_COLOR}'

TRAPWINCH() {
  zle && zle reset-prompt
}