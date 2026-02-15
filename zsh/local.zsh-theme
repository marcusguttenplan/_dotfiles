# --- local.zsh-theme ---

# 1. Theme Definitions (The Registry)
# Format: "BaseColor:ContrastColor"
typeset -A THEMES
THEMES=(
  "green"           "118:203"    # Lime / Red
  "blue"            "33:220"     # Blue / Yellow
  "purple"          "135:208"    # Purple / Orange
  "cyber"           "201:051"    # Hot Pink / Cyan
  "monochrome"      "245:255"   # Grey / White
  "dracula"         "141:212"    # Lush Purple / Soft Cyan
  "nord"            "110:153"    # Frost Blue / Slate Grey
  "nord-orange"     "110:208"    # Frost Blue / Slate Grey
  "nord-yellow"     "110:220"    # Frost Blue / Slate Grey
  "nord-gray"       "245:220"    # Frost Blue / Slate Grey
  "monokai"         "197:148"    # Pro Magenta / Earthy Orange
  "forest"          "034:214"    # Deep Green / Gold Leaf
  "ocean"           "031:081"    # Deep Blue / Sky Blue
  "lava"            "196:208"    # Pure Red / Safety Orange
  "hacker"          "046:010"    # Matrix Green / Bright Lime
  "synthwave"       "201:171"    # Hot Pink / Light Purple
  "midnight"        "024:051"    # Deep Navy / Electric Cyan
  "tokyo-night"     "025:197"    # Slate Blue / Vivid Pink
  "ember"           "240:202"    # Dark Charcoal / Sunset Orange
  "obsidian"        "240:082"    # Dark Grey / Fluorescent Green
  "amethyst"        "054:147"    # Dark Deep Purple / Soft Lavender
  "nebula"          "018:213"    # Deep Space Blue / Orchid Pink
)

# 2. Cleanup & Module Loading
autoload -Uz add-zsh-hook vcs_info
setopt PROMPT_SUBST

# 3. VCS Config
zstyle ':vcs_info:git:*' formats 'on %F{magenta} %b%u%c%f '
zstyle ':vcs_info:git:*' actionformats 'on %F{red} %b|%a%f '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{203}*%f' # Red asterisk for dirty
zstyle ':vcs_info:*' stagedstr '%F{118}+%f'   # Green plus for staged

# 4. Helper: Get Current Colors
# Determines theme based on Environment Variable or Directory
_get_theme_colors() {
  local selected=${TERM_THEME:-green}
  
  # Directory-based override
  if [[ "$PWD" == *"/work"* || "$PWD" == *"/_office"* ]]; then
    selected="nord-yellow"
  fi

  # Fallback if theme doesn't exist in our map
  [[ -z "${THEMES[$selected]}" ]] && selected="green"

  # Split the value into Base and Contrast
  local val="${THEMES[$selected]}"
  echo "${val%:*} ${val#*:}" # Returns "Base Contrast"
}

draw_line() {
  local colors=($(_get_theme_colors))
  local BASE="%B%F{${colors[1]}}"
  echo -n "${BASE}${(r:$COLUMNS::_:)}%b%f\n"
}

set_colors_hook() {
  local colors=($(_get_theme_colors))
  BASE_COLOR="%B%F{${colors[1]}}"
  CONTRAST_COLOR="%B%F{${colors[2]}}"
  vcs_info
}
add-zsh-hook precmd set_colors_hook

# 5. Prompt Construction
PROMPT='$(draw_line)${BASE_COLOR}| %b%f${CONTRAST_COLOR}%~ ${vcs_info_msg_0_}%B%F{white}@%m ${BASE_COLOR}(%b%f${CONTRAST_COLOR}%n%b%f${BASE_COLOR}) 
${BASE_COLOR}| => %b%f'

PS2='${BASE_COLOR}| => %b%f'