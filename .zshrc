# =========================
#   Configuración Zsh Bonita (Una línea)
# =========================

# Historial
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS SHARE_HISTORY INC_APPEND_HISTORY

# Calidad de vida
setopt AUTO_CD
setopt CORRECT
setopt PROMPT_SUBST
autoload -Uz compinit && compinit

# Colores
autoload -Uz colors && colors

# --- Función para mostrar estado Git ---
prompt_git() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local branch dirty
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
    dirty="*"
  else
    dirty=""
  fi
  echo "[git:${branch}${dirty}]"
}

# --- Prompt ---
# [usuario][ruta][git] $
PROMPT='%F{green}%n%f %F{blue}%~%f%F{yellow}$(prompt_git)%f : '

# Asegura que no haya alias/función previos con el mismo nombre
unalias gc 2>/dev/null
unset -f gc 2>/dev/null

# función para hacer commit rápido con gc
gc() {
  git commit -m "$*"
}

# Alias útiles
alias ll='ls -lh --group-directories-first'
alias la='ls -lha --group-directories-first'
alias gs='git status -sb'
alias ga='git add .'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
