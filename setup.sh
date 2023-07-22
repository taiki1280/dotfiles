#!/usr/bin/zsh
DOT_FILES=(.zsh_profile .zshrc .vimrc .gitconfig .prettierrc)
BACKUP_DIR=$HOME/dotfiles_bak/

for file in ${DOT_FILES[@]}; do
  if [ -f $HOME/$file ]; then
    echo -e "already exists「$HOME/$file」\nSo,will create backup files and overwrite save these."
    if [ ! -d $BACKUP_DIR ]; then
      # 存在しない場合は作成
      mkdir -v $BACKUP_DIR
      echo 'created directory for backup'
    fi
    cp $HOME/$file $BACKUP_DIR$file
    echo "created right one 「${BACKUP_DIR}$file」"
  fi
  ln -svf $HOME/git/taiki/dotfiles/$file $HOME/
  echo 'created symbolic link'
  if [ $file = '.zshrc' ]; then
    # 「zsh」は「.vimrc」に非対応。また、「.vimrc」は起動する度に読み込むらしいので不要
    # 「.gitconfig」もsourceする必要は無いと思ったため読み込む.zshrcのみへ修正
    echo "run next command 'source $HOME/$file'"
    source $HOME/$file
  fi
done
