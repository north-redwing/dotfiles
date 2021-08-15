#!/bin/sh
 
if [ "$(uname)" = 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

# zsh install
if [ $OS = 'Mac' ]; then
  brew install zsh
elif[ $OS = 'Linux' ]; then
  sudo apt install zsh
fi
chsh -s /bin/zsh

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# setting file
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# theme file
curl https://raw.github.com/davidjrice/prezto_powerline/master/prompt_powerline_setup > ~/.zprezto/modules/prompt/functions/prompt_powerline_setup

# font install
if [ $OS = 'Mac' ]; then
  # tapでリポジトリを追加する
  brew tap sanemat/font
  # フォントのinstall
  brew install ricty --with-powerline
  # 展開
  cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
  # キャッシュの削除
  fc-cache -vf  
elif[ $OS = 'Linux' ]; then
  sudo apt install -y fonts-ricty-diminished
fi

# dein install
cd ~/
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
mkdir ~/.cache/dein
sh ./installer.sh ~/.cache/dein
mkdir .vim/rc/
touch .vim/rc/dein.toml .vim/rc/dein_lazy.toml
