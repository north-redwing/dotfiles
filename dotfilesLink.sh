#!/bin/sh
 
if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi
 
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim/rc/dein.toml ~/.vim/rc/dein.toml
ln -sf ~/dotfiles/.vim/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
if [ $OS == 'Mac' ]; then 
    ln -sf ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
fi
