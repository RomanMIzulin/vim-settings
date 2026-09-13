# If you come from bash you might have to change your $Psource ~/zsh_plugins/zsh-snap/znap.zsh
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
FPATH=/home/linuxbrew/.linuxbrew/share/zsh-abbr:$FPATH
export ZSH="$HOME/.oh-my-zsh"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
zsh-syntax-highlighting
colorize
colored-man-pages
fasd
zsh-autosuggestions
docker docker-compose
jsontools
golang
pyenv
python
virtualenv

)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export PATH="$HOME/neovim:$PATH"
export PATH="$HOME/go/bin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias python=python3
alias p=python3


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias gs='git status'
alias n='nvim'

export PATH=$PATH:/usr/local/go/bin
KEYTIMEOUT=1000

eval "$(atuin init zsh)"
alias ci='glab ci view'

alias recent_branches='gb -l --sort committerdate --no-merged | tail'

. "$HOME/.cargo/env"


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source /home/linuxbrew/.linuxbrew/share/zsh-abbr/zsh-abbr.zsh


# bun completions
[ -s "/home/rmatveev/.bun/_bun" ] && source "/home/rmatveev/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
source /usr/share/nvm/init-nvm.sh

# pnpm
export PNPM_HOME="/home/rmatveev/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


eval "$(uv generate-shell-completion zsh)"

alias ls='eza -l'

eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alias tc-slow='sudo tc qdisc replace dev wlp0s20f3 root netem delay 700ms 200ms rate 2mbit'
alias tc-pain='sudo tc qdisc replace dev wlp0s20f3 root netem delay 1000ms 300ms rate 500kbit'
alias tc-hell='sudo tc qdisc replace dev wlp0s20f3 root netem delay 2000ms 500ms rate 50kbit'
alias tc-free='sudo tc qdisc del dev wlp0s20f3 root 2>/dev/null && echo "traffic restored"'

# Claude Code modes
alias cc='claude --model sonnet --effort high'
alias ccc='CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --model opus --effort max'

# docs-mcp-server: use system chromium (bundled headless-shell SIGSEGVs on Manjaro/glibc 2.43)
export PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium

# work account: separate config dir => separate login, settings, history
alias ccw='CLAUDE_CONFIG_DIR=$HOME/.claude-work claude --model opus --effort max'

# gst — multi-repo git status across a symlink workspace.
# At a workspace root (not itself a repo) it scans immediate child dirs,
# resolves symlinks, drops nested dupes (e.g. sky_ledger lives inside
# findocs_ba, so the repo is shown once), and prints git status for each.
# Inside a single repo it's just `git status`. Flags pass through, so
# `gst -sb` works; bare `gst` in multi-repo mode defaults to `-sb`.
# Overrides oh-my-zsh's `alias gst='git status'`.
unalias gst 2>/dev/null
gst() {
	emulate -L zsh
	local -a cands keep args
	local name real i j r rc=0

	# Inside a repo already -> behave like the original gst.
	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		git status "$@"
		return $?
	fi

	# Gather immediate children that are git repos (symlinks resolved).
	for name in *; do
		[[ -d "$name" ]] || continue
		real="${name:A}"
		git -C "$real" rev-parse --git-dir >/dev/null 2>&1 || continue
		cands+=("$real")
	done
	(( ${#cands[@]} )) || { git status "$@"; return $?; }

	# Drop repos nested inside another candidate (sky_ledger ⊂ findocs_ba).
	for i in "$cands[@]"; do
		for j in "$cands[@]"; do
			[[ "$i" != "$j" ]] && [[ "${i#${j}/}" != "$i" ]] && continue 2
		done
		keep+=("$i")
	done

	args=("$@")
	(( ${#args[@]} )) || args=(-sb)   # compact overview by default

	for r in "$keep[@]"; do
		print -P "%F{cyan}══ $r:%f"
		git -C "$r" status "$args[@]" || rc=$?
		echo
	done
	return $rc
}
