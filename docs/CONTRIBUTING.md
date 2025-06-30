# 🤝 Contributing Guide

## 📝 コミットメッセージ規約

このプロジェクトでは [Conventional Commits](https://www.conventionalcommits.org/) に従ったコミットメッセージを使用します。

### フォーマット

```
type(scope): description

[optional body]

[optional footer(s)]
```

### タイプ一覧

| タイプ | 説明 | 例 |
| --- | --- | --- |
| `feat` | 新機能の追加 | `feat(git): add automatic account switching` |
| `fix` | バグ修正 | `fix(zsh): resolve keychain installation issue` |
| `docs` | ドキュメントのみの変更 | `docs(readme): add installation guide` |
| `style` | コードフォーマット | `style(zsh): fix indentation` |
| `refactor` | リファクタリング | `refactor(zsh): split .zshrc into modules` |
| `perf` | パフォーマンス改善 | `perf(zsh): optimize startup time` |
| `test` | テストの追加・修正 | `test(install): add installation tests` |
| `chore` | ビルド・設定変更 | `chore(gitignore): add macOS files` |

### スコープ例

-   `git` - Git 関連の設定
-   `zsh` - zsh/シェル関連
-   `ssh` - SSH 設定
-   `install` - インストールスクリプト
-   `docs` - ドキュメント
-   `config` - 設定ファイル

### 良い例

```bash
feat(git): add automatic GitHub account switching by directory
fix(zsh): install keychain on macOS using homebrew
docs(readme): add Japanese documentation
refactor(install): improve error handling and logging
chore(gitignore): exclude temporary and backup files
```

### 悪い例

```bash
update
fix bug
add new feature
[update] いろいろ修正
```

## 🔄 ブランチ戦略

-   `main` - メインブランチ（安定版）
-   `feature/xxx` - 新機能開発
-   `fix/xxx` - バグ修正
-   `docs/xxx` - ドキュメント更新

## 📋 Pull Request

1. 分かりやすいタイトルと説明
2. 関連する issue へのリンク
3. テスト環境での動作確認
4. スクリーンショット（UI 変更の場合）

## ✅ チェックリスト

-   [ ] コミットメッセージが Conventional Commits に従っている
-   [ ] コードの動作確認済み（macOS/WSL2）
-   [ ] ドキュメントの更新（必要に応じて）
-   [ ] 個人情報や秘密情報が含まれていない
