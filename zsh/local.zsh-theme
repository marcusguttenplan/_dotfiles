# --- local.zsh-theme ---

# 1. Cleanup & Module Loading
unset -f precmd 2>/dev/null
autoload -Uz add-zsh-hook
autoload -Uz vcs_info # Load Version Control System info
add-zsh-hook -D precmd "*"

# 2. VCS Configuration
# %b = branch name, %u = unstaged changes, %c = staged changes
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%B%F{white}on %F{magenta} %b%u%c%f '
zstyle ':vcs_info:git:*' actionformats '%B%F{white}on %F{red} %b|%a%f '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*' # Indicator for dirty working tree
zstyle ':vcs_info:*' stagedstr '+'   # Indicator for staged changes

# 3. Dynamic Theme Engine
setopt PROMPT_SUBST

draw_line() {
  local theme=${TERM_THEME:-green}
  if [[ "$PWD" == *"/work"* || "$PWD" == *"/_office"* ]]; then
    local current_theme="blue"
  else
    local current_theme="$theme"
  fi

  if [[ "$current_theme" == "blue" ]]; then
    BASE="%B%F{blue}"
  else
    BASE="%B%F{118}" 
  fi
  
  # Draw horizontal line based on terminal width
  echo -n "${BASE}${(r:$COLUMNS::_:)}%b%f\n"
}

# 4. Prompt Construction
# Added ${vcs_info_msg_0_} to the middle of the prompt
PROMPT='$(draw_line)${BASE_COLOR}| %b%f${CONTRAST_COLOR}%~ ${vcs_info_msg_0_}%B%F{white}@%m ${BASE_COLOR}(%b%f${CONTRAST_COLOR}%n%b%f${BASE_COLOR}) 
${BASE_COLOR}| => %b%f'

PS2='${BASE_COLOR}| => %b%f'

# 5. Hooks
set_colors_hook() {
  local theme=${TERM_THEME:-green}
  if [[ "$PWD" == *"/work"* || "$PWD" == *"/_office"* ]] || [[ "$theme" == "blue" ]]; then
    BASE_COLOR="%B%F{blue}"
    CONTRAST_COLOR="%B%F{yellow}"
  else
    BASE_COLOR="%B%F{118}"
    CONTRAST_COLOR="%B%F{203}"
  fi
  
  vcs_info # Call this during precmd to refresh git status
}
add-zsh-hook precmd set_colors_hook