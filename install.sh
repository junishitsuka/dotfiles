# make symbolic link
ln -sf .vimrc ~/
ln -sf .zshrc ~/
ln -sf .tmux.conf ~/
ln -sf .gitignore ~/
ln -sf .gitconfig ~/
ln -sf .tmux.conf ~/

# install neobundle
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
