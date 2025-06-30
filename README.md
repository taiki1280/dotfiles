# 🏠 Dotfiles

クロスプラットフォーム開発環境用のパーソナル dotfiles（macOS & WSL2 対応）

## ✨ 主な機能

-   🔄 **クロスプラットフォーム対応**: macOS と WSL2/Linux の両方で動作
-   🔐 **Git マルチアカウント**: ディレクトリに応じて GitHub アカウントを自動切り替え
-   ⚡ **スマートシェル**: 自動補完、シンタックスハイライト、履歴管理
-   🛠 **開発ツール統合**: モダンな開発環境を事前設定
-   🐳 **Docker 統合**: 自動起動と最適化設定

## 🚀 クイックスタート

### ワンライン インストール

```bash
curl -fsSL https://raw.githubusercontent.com/taiki1280/dotfiles/main/install.sh | bash
```

### 手動インストール

```bash
git clone https://github.com/taiki1280/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## 📋 含まれる設定

### シェル設定

-   **zsh** と Oh My Zsh
-   **自動候補表示** と **シンタックスハイライト**
-   **スマート履歴** （重複除去機能付き）
-   **クロスプラットフォーム エイリアス** （ls → exa など）

### Git 設定

-   🏢 **会社用アカウント**: `/Users/taiki/work/`
-   🏠 **個人用アカウント**: `/Users/taiki/github/taiki1280/` 配下では `taiki1280`
-   🔄 **URL 自動変換**: HTTPS → SSH（適切なアカウントで）

### 開発ツール

-   **Cursor/VSCode** 統合
-   **Docker** 自動起動（WSL2 のみ）
-   **SSH キーチェーン** 管理
-   **Homebrew** サポート（macOS）

## 🔧 プラットフォーム別機能

### macOS

-   Homebrew パッケージ管理
-   macOS 専用エイリアスと設定
-   ネイティブクリップボード連携

### WSL2/Linux

-   Windows クリップボード連携
-   Docker デーモン管理
-   ポートフォワーディング サポート

## 📖 ドキュメント

-   [セットアップガイド](docs/SETUP.md) - 詳細なインストールと設定手順
-   [Git マルチアカウント](docs/GIT-MULTI-ACCOUNT.md) - 自動アカウント切り替えの仕組み
-   [トラブルシューティング](docs/TROUBLESHOOTING.md) - よくある問題と解決方法

## 🐳 Dev Containers

開発コンテナーに最適！VS Code の設定に以下を追加：

```json
{
    "dotfiles.repository": "taiki1280/dotfiles",
    "terminal.integrated.defaultProfile.linux": "zsh"
}
```

## 🛠 カスタマイズ

個人用のカスタマイズは `~/.zsh_profile` に記述してください（上書きされません）。

## 📝 ライセンス

MIT License - 自由に使用・改変してください！

---

**注意**: この dotfiles には Git アカウントの自動切り替え機能が含まれています。ご自分の環境で使用する前に Git 設定を確認してください。
