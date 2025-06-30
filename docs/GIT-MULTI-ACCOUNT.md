# 🔄 Git マルチアカウント設定

このドキュメントでは、ディレクトリに応じて GitHub アカウントを自動切り替えする仕組みについて詳しく説明します。

## 概要

この dotfiles は、作業ディレクトリに応じて以下のように自動的に Git アカウントを切り替えます：

-   **個人用**: `/Users/taiki/github/taiki1280/` 配下
-   **会社用**: その他のディレクトリ

## 仕組みの詳細

### 1. 条件付き Git 設定

`.gitconfig` に以下の設定が自動的に追加されます：

```ini
[includeIf "gitdir:/Users/taiki/github/taiki1280/"]
    path = ~/.config/git/personal-config

[user]
    name = work-user
    email = work-user@company.com
```

個人用設定ファイル `~/.config/git/personal-config`：

```ini
[user]
    name = taiki1280
    email = taiki.kawagishi.private@gmail.com
```

### 2. SSH 設定

#### 個人用 SSH 設定

`~/.ssh/conf.d/personal/taiki/config`:

```
Host github.com-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/conf.d/personal/taiki/id_ed25519
    IdentitiesOnly yes
```

#### 会社用 SSH 設定

`~/.ssh/conf.d/work/github/config`:

```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/conf.d/work/github/id_ed25519
    IdentitiesOnly yes
```

### 3. 自動クローン機能

`gclone` 関数により、ディレクトリに応じて適切な SSH URL を自動選択：

```bash
# 個人ディレクトリでの実行
cd /Users/taiki/github/taiki1280/
gclone https://github.com/user/repo.git
# → git clone git@github.com-personal:user/repo.git

# 会社ディレクトリでの実行
cd /Users/taiki/work/
gclone https://github.com/user/repo.git
# → git clone git@github.com:user/repo.git
```

## 使用方法

### 1. 新しいリポジトリのクローン

```bash
# 個人用ディレクトリに移動
cd /Users/taiki/github/taiki1280/

# gclone関数を使用（推奨）
gclone https://github.com/taiki1280/my-project.git

# または手動でSSH URLを指定
git clone git@github.com-personal:taiki1280/my-project.git
```

### 2. 既存リポジトリのリモート変更

```bash
# 現在のリモートURL確認
git remote -v

# 個人用アカウントに変更
git remote set-url origin git@github.com-personal:taiki1280/repo.git

# 会社用アカウントに変更
git remote set-url origin git@github.com:work-user/repo.git
```

### 3. 設定確認

```bash
# 現在のGit設定を確認
git config user.name
git config user.email

# または設定確認関数を使用
git-check-config
```

## SSH 鍵の設定

### 1. SSH 鍵の生成

```bash
# 個人用SSH鍵
ssh-keygen -t ed25519 -C "taiki.kawagishi.private@gmail.com" -f ~/.ssh/conf.d/personal/taiki/id_ed25519

# 会社用SSH鍵
ssh-keygen -t ed25519 -C "work-user@company.com" -f ~/.ssh/conf.d/work/github/id_ed25519
```

### 2. 公開鍵を GitHub に登録

```bash
# 個人用公開鍵をクリップボードにコピー（macOS）
pbcopy < ~/.ssh/conf.d/personal/taiki/id_ed25519.pub

# 個人用公開鍵をクリップボードにコピー（WSL2）
clip.exe < ~/.ssh/conf.d/personal/taiki/id_ed25519.pub
```

### 3. 接続テスト

```bash
# 個人用アカウント
ssh -T git@github.com-personal

# 会社用アカウント
ssh -T git@github.com
```

## トラブルシューティング

### よくある問題

#### 1. SSH 鍵が認識されない

```bash
# SSH設定を確認
ssh -T -v git@github.com-personal

# SSH Agentに鍵を追加
ssh-add ~/.ssh/conf.d/personal/taiki/id_ed25519
```

#### 2. 間違ったアカウントでコミットしてしまった

```bash
# 最新のコミットの作者を変更
git commit --amend --author="taiki1280 <taiki.kawagishi.private@gmail.com>"

# 複数のコミットを変更する場合
git rebase -i HEAD~3  # 直近3コミット
```

#### 3. リモート URL が間違っている

```bash
# 現在のリモートURL確認
git remote -v

# 正しいURLに変更
git remote set-url origin git@github.com-personal:taiki1280/repo.git
```

## 高度な設定

### カスタムディレクトリパターン

独自のディレクトリ構造を使用する場合、`.gitconfig` を編集：

```ini
[includeIf "gitdir:~/projects/personal/"]
    path = ~/.config/git/personal-config

[includeIf "gitdir:~/projects/work/"]
    path = ~/.config/git/work-config
```

### 複数の会社アカウント

```ini
[includeIf "gitdir:~/work/company-a/"]
    path = ~/.config/git/company-a-config

[includeIf "gitdir:~/work/company-b/"]
    path = ~/.config/git/company-b-config
```

## 参考資料

-   [Git Config Documentation](https://git-scm.com/docs/git-config)
-   [SSH Config Documentation](https://man.openbsd.org/ssh_config)
-   [GitHub SSH Documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
