#!/usr/bin/env bash
set -euo pipefail # エラー時即座に終了

# カラー出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ログ関数
log() {
  echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $*"
}

success() {
  echo -e "${GREEN}✅ $*${NC}"
}

warning() {
  echo -e "${YELLOW}⚠️  $*${NC}"
}

error() {
  echo -e "${RED}❌ $*${NC}"
}
log "🏠 Dotfiles セットアップを開始します"
echo
log "処理内容:"
log "  1. ホームディレクトリに既存ファイルがある場合、バックアップを作成"
log "  2. dotfiles のシンボリックリンクを作成"
log "  3. 必要なツールのインストール"
echo

# dotfiles リスト取得（ファイルのみ、ディレクトリと特殊ファイルを除外）
DOT_FILES=()
for file in .*; do
  # .と..を除外、ディレクトリを除外、.gitを除外
  if [[ "$file" != "." && "$file" != ".." && ! -d "$file" && "$file" != ".git"* ]]; then
    DOT_FILES+=("$file")
  fi
done
BACKUP_DIR="$HOME/.dotfiles-backup"

if [ ${#DOT_FILES[@]} -eq 0 ]; then
  error "dotfiles が見つかりません"
  exit 1
fi

log "処理対象ファイル: ${DOT_FILES[*]}"
echo

log "📂 シンボリックリンクを作成中..."

for file in "${DOT_FILES[@]}"; do
  log "処理中: $file"

  target="$HOME/$file"
  source="$PWD/$file"

  # 既存ファイルのバックアップ
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    if [ ! -d "$BACKUP_DIR" ]; then
      mkdir -p "$BACKUP_DIR"
      log "バックアップディレクトリを作成: $BACKUP_DIR"
    fi

    backup_name="$file.$(date +%Y%m%d_%H%M%S)"
    mv "$target" "$BACKUP_DIR/$backup_name"
    warning "既存ファイルをバックアップ: $backup_name"
  fi

  # シンボリックリンク作成
  if ln -sf "$source" "$target"; then
    success "リンク作成: $file"
  else
    error "リンク作成失敗: $file"
  fi
done

echo

log "🔧 必要なツールをインストール中..."

# oh-my-zsh インストール
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log "oh-my-zsh をインストール中..."
  if sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended; then
    success "oh-my-zsh インストール完了"
  else
    error "oh-my-zsh インストール失敗"
  fi
else
  log "oh-my-zsh は既にインストールされています"
fi

# プラグインインストール
log "oh-my-zsh プラグインをインストール中..."
PLUGIN_LIST=('zsh-autosuggestions' 'zsh-syntax-highlighting')

for plugin in "${PLUGIN_LIST[@]}"; do
  plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin"

  if [ ! -d "$plugin_dir" ]; then
    log "プラグインをインストール中: $plugin"
    if git clone "https://github.com/zsh-users/$plugin" "$plugin_dir"; then
      success "プラグインインストール完了: $plugin"
    else
      error "プラグインインストール失敗: $plugin"
    fi
  else
    log "プラグインは既にインストールされています: $plugin"
  fi
done

# Lima Docker自動起動を設定（macOSのみ）
if [[ "$OSTYPE" == "darwin"* ]]; then
  if command -v limactl >/dev/null 2>&1; then
    log "Lima Docker自動起動を設定中..."
    if limactl start-at-login default 2>/dev/null; then
      success "Lima Docker自動起動を有効化しました"
    else
      warning "Lima Docker自動起動の設定に失敗しました（手動で実行してください: limactl start-at-login default）"
    fi
  else
    warning "limaがインストールされていません"
  fi
fi

echo
success "🎉 dotfiles セットアップが完了しました！"
echo
log "ターミナルを再起動するか、以下のコマンドを実行してください:"
echo "  source ~/.zshrc"
echo
