# 📋 セットアップガイド

このドキュメントでは、dotfiles の詳細なセットアップ手順とカスタマイズ方法について説明します。

## 前提条件

### macOS

-   macOS 10.15 (Catalina) 以降
-   Homebrew がインストール済み（推奨）
-   Xcode Command Line Tools

### WSL2/Linux

-   Ubuntu 20.04 以降（WSL2 の場合）
-   curl、git がインストール済み
-   sudo 権限

## インストール方法

### 1. クイックインストール（推奨）

```bash
curl -fsSL https://raw.githubusercontent.com/taiki1280/dotfiles/main/install.sh | bash
```

### 2. 手動インストール

```bash
# リポジトリをクローン
git clone https://github.com/taiki1280/dotfiles.git ~/dotfiles
cd ~/dotfiles

# インストールスクリプトを実行
./install.sh
```

### 3. 特定のファイルのみインストール

```bash
# 特定の設定ファイルのみリンク
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
```

## 詳細設定

### zsh 設定

インストール後、以下のファイルが設定されます：

-   `~/.zshrc` - メインの設定ファイル
-   `~/.zsh_profile` - 個人用カスタマイズファイル（作成される）

### Git 設定

自動的に以下の Git 設定が適用されます：

#### 条件付き設定

-   `/Users/taiki/github/taiki1280/` - 個人用アカウント
-   その他のディレクトリ - 会社用アカウント

#### SSH 設定

-   `~/.ssh/conf.d/personal/taiki/config` - 個人用 SSH 設定
-   `~/.ssh/conf.d/work/github/config` - 会社用 SSH 設定

### 開発ツール

以下のツールが自動的に設定されます：

#### macOS

-   Homebrew パッケージ管理
-   keychain（SSH 鍵管理）
-   exa（ls の代替）

#### WSL2/Linux

-   Docker デーモン自動起動
-   Windows クリップボード連携
-   ポートフォワーディング

## カスタマイズ

### 個人用設定

個人用のカスタマイズは `~/.zsh_profile` に記述してください：

```bash
# ~/.zsh_profile
export MY_CUSTOM_VAR="value"
alias mycmd="echo 'Hello World'"

# パスの追加
export PATH="$HOME/bin:$PATH"
```

### エイリアスの追加

```bash
# ~/.zsh_profile
alias ll="exa -la"
alias grep="grep --color=auto"
alias ..="cd .."
alias ...="cd ../.."
```

### 環境変数

```bash
# ~/.zsh_profile
export EDITOR="vim"
export BROWSER="open"
export TERM="xterm-256color"
```

## アンインストール

dotfiles を削除する場合：

```bash
# シンボリックリンクを削除
unlink ~/.zshrc
unlink ~/.vimrc

# dotfilesディレクトリを削除
rm -rf ~/dotfiles

# zsh設定をリセット
rm -f ~/.zsh_profile
```

## トラブルシューティング

設定で問題が発生した場合は、[トラブルシューティングガイド](TROUBLESHOOTING.md)を参照してください。

## 次のステップ

-   [Git マルチアカウント設定](GIT-MULTI-ACCOUNT.md)の詳細を確認
-   開発環境に合わせて `~/.zsh_profile` をカスタマイズ
-   SSH 鍵の設定を確認
