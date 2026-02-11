# --- test.zsh-theme ---

# 1. Cleanup
unset -f precmd 2>/dev/null
autoload -Uz add-zsh-hook
add-zsh-hook -D precmd "*"

# 2. Dynamic Theme Engine
setopt PROMPT_SUBST

# We create a function that returns the line string
# This allows us to inject it directly into the PROMPT variable
draw_line() {
  local theme=${TERM_THEME:-green}
  
  # Directory-based overrides
  if [[ "$PWD" == *"/work"* || "$PWD" == *"/aws"* ]]; then
    local current_theme="blue"
  else
    local current_theme="$theme"
  fi

  # Set colors
  if [[ "$current_theme" == "blue" ]]; then
    BASE="%B%F{blue}"
    CONTRAST="%B%F{yellow}"
  else
    BASE="%B%F{118}" # Limegreen
    CONTRAST="%B%F{203}" # Red
  fi
  
  # Return the line: Color + Underscores + Reset + Newline
  echo -n "${BASE}${(r:$COLUMNS::_:)}%b%f\n"
}

# 3. Prompt Construction
# We call $(draw_line) at the very start of the PROMPT string
PROMPT='$(draw_line)${BASE_COLOR}| %b%f%~ %B%F{white}@%m ${BASE_COLOR}(%b%f${CONTRAST_COLOR}%n%b%f${BASE_COLOR}) 
${BASE_COLOR}| => %b%f'

PS2='${BASE_COLOR}| => %b%f'

# 4. Helper to ensure colors are set for the rest of the prompt
set_colors_hook() {
  local theme=${TERM_THEME:-green}
  if [[ "$PWD" == *"/work"* || "$PWD" == *"/aws"* ]] || [[ "$theme" == "blue" ]]; then
    BASE_COLOR="%B%F{blue}"
    CONTRAST_COLOR="%B%F{yellow}"
  else
    BASE_COLOR="%B%F{118}"
    CONTRAST_COLOR="%B%F{203}"
  fi
}
add-zsh-hook precmd set_colors_hook