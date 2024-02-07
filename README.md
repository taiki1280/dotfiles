# devcontainer で読み込む場合

`vscode` の `settings.json` に以下を追記してください。

```json
{
    "dotfiles.repository": "taiki1280/dotfiles"
}
```

## 注意点

`wsl2` 上の `settings.json` に記載しても設定は読み込まれなかったです。  
`Windows` 上の `settings.json` に記載しないといけません。  
需要があるのかわからないですが、 `Windows` 上のものに何も書かずとも、  
`devcontainer.json` の `vscode` `settings` に記載することでも動作します。

## コメント

`dotfiles` の設定項目には他にも以下の二点があります。

1. `dotfiles.targetPath`
1. `dotfiles.installCommand`

わざわざ変更するメリットが感じられず、デフォルトで使用したいと思ったのでターゲットパスは `~/dotfiles` コマンドのシェルスクリプトファイル名は `install.sh` と合わせています。
