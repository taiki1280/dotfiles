# Dev Containers で読み込む場合

## 前提

1. OS `Windows`
1. `WSL2` を使用
1. `vscode` が `Windows` にインストール済
1. 拡張機能 `Dev Containers` を使用

`vscode` の `settings.json` に以下を追記してください。適用方法は二点あります。

1. `settings.json` `Windows` 側ユーザー設定へ追記

    ```json
    {
        "dotfiles.repository": "taiki1280/dotfiles",
        "terminal.integrated.defaultProfile.linux": "zsh"
    }
    ```

1. `devcontainer.json` の `customizations` `vscode` `settings` に記載

    ```json
    "customizations": {
        "vscode": {
            "settings": {
                "dotfiles.repository": "taiki1280/dotfiles",
                "terminal.integrated.defaultProfile.linux": "zsh"
            }
        }
    },
    ```

## 注意点

1. `wsl2` 上のユーザーの `settings.json` に記載しても適用されません

## コメント

`dotfiles` の設定項目には他にも以下の二点があります。

1. `dotfiles.targetPath`
1. `dotfiles.installCommand`

デフォルトはそれぞれ `~/dotfiles` `install.sh` 等です。  
わざわざデフォルトから変更するメリットが今のところないので、 `dotfiles.repository` のみを設定しています。
