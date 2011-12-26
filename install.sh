#!/usr/bin/env bash

set -e

cd `dirname $0`
export DOTFILES=`pwd`

source $DOTFILES/install_functions.sh

update_submodules

link_with_backup .bashrc
link_with_backup .bash_profile
link_with_backup .gitconfig
link_with_backup .rvmrc
link_with_backup .tmux.conf

link_with_backup .emacs.d
install_elpa
link_with_backup .emacs
link_with_backup .emacs-custom.el

(
    cd $DOTFILES/.emacs.d/local &&
    git clone --depth 1 git@github.com:stuartsierra/org-mode.git &&
    cd org-mode
    make
)

install_relevance_etc


backup ~/.relevance-etc
ln -s $DOTFILES/submodules/relevance/etc $HOME/.relevance-etc
