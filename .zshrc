# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME='jonathan'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=("jonathan" "agnoster")

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto # update automatically without asking
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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # oh-my-zsh 初期プラグイン（元々入っているもの）
  docker
  docker-compose
  vscode
  z
  copypath
  git
  history
  rsync
  aws
  npm
  composer
  python
  cakephp3
  terraform
  # 外部プラグイン
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# OS別プラグイン追加
if [[ $(uname -r) =~ microsoft ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # WSL/Linux環境でのみubuntuプラグインを追加
  plugins+=(ubuntu)
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS環境で必要に応じて追加
  plugins+=(macos)
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if command -v cursor >/dev/null 2>&1; then
  export EDITOR='cursor --wait "$@"'
elif command -v code >/dev/null 2>&1; then
  export EDITOR='code --wait "$@"'
else
  export EDITOR='vim'
fi
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
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

# ヒストリー機能
HISTFILE=~/.zsh_history     # ヒストリファイルを指定
HISTSIZE=10000              # ヒストリに保存するコマンド数
SAVEHIST=10000              # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups     # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history        # コマンド履歴ファイルを共有する
setopt append_history       # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks   # 余分な空白は詰めて記録

# auto change directory
setopt auto_cd

function _ssh {
  compadd $(grep '^Host ' ~/.ssh/conf.d/personal/*/config | grep -v '*' | awk '{print $2}' | sort)
  if [ "${HOST:0:5}" != 'taiki' ]; then
    compadd $(grep '^Host ' ~/.ssh/conf.d/work/*/config | grep -v '*' | grep -v 'db' | awk '{print $2}' | sort)
  fi
}

# enable color support of ls and also add handy aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
  alias ls='ls -G'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
elif [ -x /usr/bin/dircolors ]; then
  # Linux/WSL
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

colorlist() {
  for color in {000..015}; do
    print -nP "%F{$color}$color %f"
  done
  printf "\n"
  for color in {016..255}; do
    print -nP "%F{$color}$color %f"
    if [ $(($((color - 16)) % 6)) -eq 5 ]; then
      printf "\n"
    fi
  done
}

# some more ls aliases
# exa インストール済の場合、 ls 系のコマンドを exa へ置換
if [[ $(command -v exa) ]]; then
  # alias e='exa --icons'
  alias e='exa'
  alias l=e
  alias ls=e
  # alias ea='exa -a --icons'
  alias ea='exa -a'
  alias la=ea
  # alias ee='exa -aal --icons'
  alias ee='exa -aal'
  alias ll=ee
  # alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache"'
  alias lt=et
  # alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always | less -r'
  alias lta=eta
else
  alias ll='ls -laFh'
  alias la='ls -A'
  alias l='ls -CF'
fi

function chpwd() {
  clear
  ll
}

# クリップボード (WSL環境でのみ有効)
if [[ $(uname -r) =~ microsoft ]]; then
  alias pbcopy='iconv -f UTF-8 -t UTF-16LE | clip.exe'
  alias pbpaste='powershell.exe -Command Get-Clipboard'
fi

# Docker daemon (WSL/Linux環境でのみ実行)
if [[ $(uname -r) =~ microsoft ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if command -v systemctl >/dev/null 2>&1 && test "$(pgrep -o systemctl)" = "1" && test $(systemctl is-active docker) = 'inactive'; then
    sudo /usr/sbin/service docker start
    echo 'Dockerが起動していなかったため、起動しておきました。'
  fi
fi

if [ -e $HOME/.zsh_profile ]; then
  source $HOME/.zsh_profile
fi

# devcontainer でないときのみ実行
if [ "${REMOTE_CONTAINERS}" != "true" ]; then
  # keychainが存在しない場合、OSに応じてインストール
  if ! command -v keychain >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      # macOS の場合
      if command -v brew >/dev/null 2>&1; then
        brew install keychain
      else
        echo "Homebrewがインストールされていません。keychainを手動でインストールしてください。"
      fi
    elif [[ $(uname -r) =~ microsoft ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
      # WSL/Linux の場合
      sudo apt install -y keychain
    fi
  fi

  # For Loading the SSH key
  # keychainコマンドが存在する場合のみ実行
  if command -v keychain >/dev/null 2>&1; then
    # keychainのパスを取得
    KEYCHAIN_PATH=$(command -v keychain)

    # id_ed25519ファイルの処理
    if find "$HOME/.ssh/conf.d/" -name "id_ed25519" -print -quit 2>/dev/null | grep -q .; then
      $KEYCHAIN_PATH -q --nogui $HOME/.ssh/conf.d/**/id_ed25519 2>/dev/null
    fi
    # .cerファイルの処理
    if find "$HOME/.ssh/conf.d/" -name "*.cer" -print -quit 2>/dev/null | grep -q .; then
      $KEYCHAIN_PATH -q --nogui $HOME/.ssh/conf.d/**/*.cer 2>/dev/null
    fi
    # .pemファイルの処理
    if find "$HOME/.ssh/conf.d/" -name "*.pem" -print -quit 2>/dev/null | grep -q .; then
      $KEYCHAIN_PATH -q --nogui $HOME/.ssh/conf.d/**/*.pem 2>/dev/null
    fi

    # keychainファイルが存在する場合のみsource
    if [ -e "$HOME/.keychain/$(hostname)-sh" ]; then
      source $HOME/.keychain/$(hostname)-sh
    fi
  fi

  # ポートフォワード (WSL環境でのみ実行)
  if [[ $(uname -r) =~ microsoft ]]; then
    if [ -e $HOME/.ssh/conf.d/port_forward.sh ]; then
      nohup bash $HOME/.ssh/conf.d/port_forward.sh >/dev/null 2>&1
    else
      echo "「$HOME/.ssh/conf.d/port_forward.sh」は存在しませんでした"
    fi
  fi
fi

# peco
function peco-history-selection() {
  BUFFER=$(history -n 1 | tac | awk '!a[$0]++' | peco)
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# GitHub用ヘルパー関数
function gclone() {
  local repo_name="$1"
  local current_dir=$(pwd)

  if [[ "$current_dir" == *"/Users/taiki/github/taiki1280"* ]]; then
    # プライベートディレクトリの場合
    echo "📋 プライベート用でクローンしています: $repo_name"
    command git clone git@github.com-personal:taiki1280/$repo_name.git
  else
    # 会社用ディレクトリの場合
    echo "🏢 会社用でクローンしています: $repo_name"
    command git clone git@github.com:$repo_name.git
  fi
}

# git コマンドのラッパー関数
function git() {
  local current_dir=$(pwd)

  # git cloneの場合のみ特別処理
  if [[ "$1" == "clone" ]]; then
    local url="$2"
    local modified_url=""

    # GitHubのSSH URLかどうかチェック
    if [[ "$url" =~ ^git@github\.com: ]]; then
      if [[ "$current_dir" == *"/Users/taiki/github/taiki1280"* ]]; then
        # プライベートディレクトリの場合、github.com-personalに変更
        modified_url=$(echo "$url" | sed 's/git@github\.com:/git@github.com-personal:/')
        echo "📋 プライベート用GitHubアカウントでクローンします"
        echo "🔗 URL: $modified_url"
        shift 2 # 最初の2つの引数（clone と url）を削除
        command git clone "$modified_url" "$@"
      else
        # 会社用ディレクトリの場合はそのまま
        echo "🏢 会社用GitHubアカウントでクローンします"
        echo "🔗 URL: $url"
        command git "$@"
      fi
    # GitHubのHTTPS URLの場合
    elif [[ "$url" =~ ^https://github\.com/ ]]; then
      if [[ "$current_dir" == *"/Users/taiki/github/taiki1280"* ]]; then
        # プライベートディレクトリの場合、SSH形式に変換してpersonalホストを使用
        if [[ "$url" =~ \.git$ ]]; then
          modified_url=$(echo "$url" | sed -E 's|https://github\.com/([^/]+)/([^/]+)\.git$|git@github.com-personal:\1/\2.git|')
        else
          modified_url=$(echo "$url" | sed -E 's|https://github\.com/([^/]+)/([^/]+)$|git@github.com-personal:\1/\2.git|')
        fi
        echo "📋 プライベート用GitHubアカウント（SSH）でクローンします"
        echo "🔗 変換: $url → $modified_url"
        shift 2 # 最初の2つの引数を削除
        command git clone "$modified_url" "$@"
      else
        # 会社用ディレクトリの場合、SSH形式に変換
        if [[ "$url" =~ \.git$ ]]; then
          modified_url=$(echo "$url" | sed -E 's|https://github\.com/([^/]+)/([^/]+)\.git$|git@github.com:\1/\2.git|')
        else
          modified_url=$(echo "$url" | sed -E 's|https://github\.com/([^/]+)/([^/]+)$|git@github.com:\1/\2.git|')
        fi
        echo "🏢 会社用GitHubアカウント（SSH）でクローンします"
        echo "🔗 変換: $url → $modified_url"
        shift 2 # 最初の2つの引数を削除
        command git clone "$modified_url" "$@"
      fi
    else
      # GitHub以外のURLはそのまま
      command git "$@"
    fi
  else
    # clone以外のgitコマンドはそのまま実行
    command git "$@"
  fi
}

function git-check-config() {
  echo "🔍 現在のGit設定:"
  echo "  ユーザー名: $(git config user.name)"
  echo "  メールアドレス: $(git config user.email)"
  echo "  リモートURL: $(git remote get-url origin 2>/dev/null || echo 'リモートURLが設定されていません')"
}
