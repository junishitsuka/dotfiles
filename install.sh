# make symbolic link
ln -sf ~/dotfiles/.vimrc ~/
ln -sf ~/dotfiles/.zshrc ~/
ln -sf ~/dotfiles/.tmux.conf ~/
ln -sf ~/dotfiles/.gitignore ~/
ln -sf ~/dotfiles/.gitconfig ~/
ln -sf ~/dotfiles/.zshfiles ~/

# install neobundle
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
