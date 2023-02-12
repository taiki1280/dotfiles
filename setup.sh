#!/usr/bin/zsh
DOT_FILES=(.zshrc .vimrc)
BACKUP_DIR=~/dotfiles_bak/

for file in ${DOT_FILES[@]}
do
    if [ -f ~/$file ]; then
        echo -e "already exists「~/${file}」\nSo,will create backup files and overwrite save these."
        if [ ! -d $BACKUP_DIR ]; then
            # 存在しない場合は作成
            mkdir -v $BACKUP_DIR
            echo 'created directory for backup'
        fi
        cp ~/$file $BACKUP_DIR$file
        echo "created right one 「${BACKUP_DIR}${file}」"
    fi
    ln -svf ~/git/taiki/dotfiles/$file ~/
    echo 'created symbolic link'
    if [ $file != ".vimrc" ]; then
        # 「zsh」は「.vimrc」に非対応。また、「.vimrc」は起動する度に読み込むらしいので不要
        echo "run next command 'source ~/${file}'"
        source ~/$file
    fi
    echo ''
done