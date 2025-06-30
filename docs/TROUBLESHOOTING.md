# 🔧 トラブルシューティング

dotfiles の使用中に発生する可能性のある問題と解決方法をまとめています。

## インストール関連

### 1. インストールスクリプトが失敗する

#### 症状

```bash
curl -fsSL https://raw.githubusercontent.com/taiki1280/dotfiles/main/install.sh | bash
# エラーが発生してインストールが中断される
```

#### 解決方法

```bash
# 手動でダウンロードして実行
wget https://raw.githubusercontent.com/taiki1280/dotfiles/main/install.sh
chmod +x install.sh
./install.sh
```

### 2. 権限エラー

#### 症状

```
Permission denied (publickey).
```

#### 解決方法

```bash
# SSH鍵のパーミッションを修正
chmod 600 ~/.ssh/conf.d/personal/taiki/id_ed25519
chmod 600 ~/.ssh/conf.d/work/github/id_ed25519
chmod 700 ~/.ssh/conf.d/personal/taiki/
chmod 700 ~/.ssh/conf.d/work/github/
```

## プラットフォーム別問題

### macOS

#### 1. Homebrew がインストールされていない

#### 症状

```bash
brew: command not found
```

#### 解決方法

```bash
# Homebrewをインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# PATHを更新
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### 2. Xcode ライセンス同意が必要

#### 症状

```
You have not agreed to the Xcode license agreements
```

#### 解決方法

```bash
sudo xcodebuild -license accept
```

### WSL2/Linux

#### 1. apt コマンドエラー

#### 症状

```bash
apt: command not found
```

#### 解決方法

dotfiles は自動的に OS を判定します。手動で修正する場合：

```bash
# .zshrcを編集
vim ~/.zshrc

# 以下の行を確認
if grep -q "microsoft" /proc/version; then
    # WSL2環境
    sudo apt update && sudo apt install -y keychain
fi
```

#### 2. Docker デーモンが起動しない

#### 症状

```bash
Cannot connect to the Docker daemon
```

#### 解決方法

```bash
# Dockerサービスを手動で開始
sudo service docker start

# 自動起動を有効化
sudo systemctl enable docker
```

#### 3. クリップボード連携が動作しない

#### 症状

```bash
clip.exe: command not found
```

#### 解決方法

```bash
# Windows側でWSL統合が有効になっているか確認
# または手動でパスを追加
export PATH="$PATH:/mnt/c/Windows/System32"
```

## Git 関連

### 1. 間違ったアカウントでコミットしてしまった

#### 症状

```bash
git log --oneline
# 意図しないユーザー名でコミットされている
```

#### 解決方法

```bash
# 最新のコミットを修正
git commit --amend --author="正しいユーザー名 <email@example.com>"

# 複数のコミットを修正
git rebase -i HEAD~3
# エディタで'edit'を選択し、各コミットで--amendを実行
```

### 2. SSH 接続ができない

#### 症状

```bash
git push origin main
Permission denied (publickey).
```

#### 解決方法

```bash
# SSH設定を確認
ssh -T git@github.com-personal
ssh -T git@github.com

# SSH Agentに鍵を追加
ssh-add ~/.ssh/conf.d/personal/taiki/id_ed25519

# 鍵がロードされているか確認
ssh-add -l
```

### 3. リモート URL が間違っている

#### 症状

```bash
git remote -v
origin  https://github.com/user/repo.git (fetch)
origin  https://github.com/user/repo.git (push)
```

#### 解決方法

```bash
# SSH URLに変更
git remote set-url origin git@github.com-personal:user/repo.git

# または会社用
git remote set-url origin git@github.com:user/repo.git
```

## zsh 関連

### 1. Oh My Zsh が正しく読み込まれない

#### 症状

```bash
zsh: command not found: omz
```

#### 解決方法

```bash
# Oh My Zshを再インストール
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 設定を再読み込み
source ~/.zshrc
```

### 2. プラグインが動作しない

#### 症状

シンタックスハイライトや自動補完が機能しない

#### 解決方法

```bash
# プラグインディレクトリを確認
ls $ZSH_CUSTOM/plugins/

# 手動でプラグインをインストール
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

### 3. 履歴が保存されない

#### 症状

コマンド履歴が次回起動時に失われる

#### 解決方法

```bash
# 履歴ファイルのパーミッションを確認
ls -la ~/.zsh_history

# パーミッションを修正
chmod 600 ~/.zsh_history

# 履歴設定を確認
echo $HISTFILE
echo $HISTSIZE
```

## パフォーマンス関連

### 1. zsh の起動が遅い

#### 症状

ターミナル起動に数秒かかる

#### 解決方法

```bash
# 起動時間を測定
time zsh -i -c exit

# プロファイリングを有効化
zmodload zsh/zprof
# .zshrcの最後に追加: zprof

# 不要なプラグインを無効化
vim ~/.zshrc
# plugins=(git) # 必要最小限のプラグインのみ
```

### 2. コマンド補完が遅い

#### 症状

Tab キーでの補完に時間がかかる

#### 解決方法

```bash
# 補完キャッシュをクリア
rm -rf ~/.zcompdump*

# 補完システムを再初期化
autoload -U compinit && compinit
```

## 設定関連

### 1. 設定が反映されない

#### 症状

.zshrc の変更が反映されない

#### 解決方法

```bash
# 設定を手動で再読み込み
source ~/.zshrc

# 構文エラーがないか確認
zsh -n ~/.zshrc

# バックアップから復元
cp ~/.zshrc.backup ~/.zshrc
```

### 2. エイリアスが動作しない

#### 症状

```bash
ll: command not found
```

#### 解決方法

```bash
# エイリアスが定義されているか確認
alias ll

# 手動でエイリアスを追加
echo 'alias ll="exa -la"' >> ~/.zsh_profile
source ~/.zsh_profile
```

## ログとデバッグ

### デバッグモードでの実行

```bash
# zshをデバッグモードで起動
zsh -x

# 特定のスクリプトをデバッグ
bash -x ./install.sh
```

### ログファイルの確認

```bash
# インストールログを確認
tail -f ~/dotfiles_install.log

# システムログを確認（Linux）
journalctl -u docker.service
```

## 完全なリセット

すべてを初期状態に戻したい場合：

```bash
# dotfilesを完全削除
rm -rf ~/dotfiles

# 設定ファイルを削除
rm -f ~/.zshrc ~/.vimrc ~/.zsh_profile

# Oh My Zshを削除
rm -rf ~/.oh-my-zsh

# zshをデフォルトに戻す
chsh -s /bin/bash

# 再インストール
curl -fsSL https://raw.githubusercontent.com/taiki1280/dotfiles/main/install.sh | bash
```

## サポート

上記で解決しない場合は、以下の情報とともに Issue を作成してください：

-   OS 情報: `uname -a`
-   zsh バージョン: `zsh --version`
-   エラーメッセージの全文
-   実行したコマンドの詳細

[GitHub で Issue を作成](https://github.com/taiki1280/dotfiles/issues/new)
