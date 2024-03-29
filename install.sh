#!/usr/bin/zsh
DOT_FILES=($(ls -d $(ls -aF | grep -v "/" | grep -v .gitignore | grep -e "^\..\+$")))
echo '同階層にあるすべての dotfiles を処理します。'
echo '\t''1. ホームディレクトリ直下に既に同じ名前のファイルがある場合、バックアップを作成して移動'
echo '\t''2. ドットファイルの新保陸リンクを作成'
echo '\t''3. .zshrc がある場合、読み込み'
echo '-----------------------------------------------------------------------------------'
BACKUP_DIR=$HOME/dotfiles_bk.d/
message_result=''

for file in ${DOT_FILES[@]}; do
  message_result="${message_result}${file}"'\n'
  if [ -f $HOME/$file ]; then
    if [ ! -d $BACKUP_DIR ]; then
      # バックアップのディレクトリが存在しない場合は作成
      mkdir -v $BACKUP_DIR
      message_result="${message_result}"'\t''created directory for backup''\n'
    fi
    message_result="${message_result}"'\t'"already exists「$HOME/$file」"'\n'
    message_result="${message_result}"'\t''So, move it to backup directory & create a new one.''\n'
    # 予め作成しているバックアップディレクトリへ移動させる
    mv $HOME/$file $BACKUP_DIR$file
  fi
  result=$(ln -svf $PWD/$file $HOME/)
  message_result="${message_result}"'\t'"created: ${result}"'\n'
done

echo '【実行結果】'
echo $message_result
echo '-----------------------------------------------------------------------------------'

echo 'oh-my-zsh が入っていない場合、インストール'
if [ ! -d $HOME/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
echo '-----------------------------------------------------------------------------------'

echo 'oh-my-zsh plugin が入っていない場合、インストール'
# plugin
PLUGIN_LIST=('zsh-autosuggestions' 'zsh-syntax-highlighting')
for plugin in ${PLUGIN_LIST[@]}; do
  if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin ]; then
    git clone https://github.com/zsh-users/$plugin ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin
  fi
done
echo '-----------------------------------------------------------------------------------'

echo '最後に .zshrc を読み込み'
if [ -e $HOME/.zshrc ]; then
  echo '-----------------------------------------------------------------------------------'
  source $HOME/.zshrc
fi
