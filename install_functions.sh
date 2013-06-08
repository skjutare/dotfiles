function backup {
    local FILE=$1
    if [ -L $FILE ]; then
        rm $FILE
    elif [ -e $FILE ]; then
        mv $FILE $FILE.bak
    fi
}

function link_with_backup {
    local FILENAME=$1
    local SOURCE=$DOTFILES/$FILENAME
    local TARGET=$HOME/$FILENAME
    backup $TARGET
    ln -s $SOURCE $TARGET
}

function install_elpa {
    rm -rf $DOTFILES/.emacs.d/elpa
    emacs --script $DOTFILES/install_elpa.el
}

function update_submodules {
    git submodule init
    git submodule update
}

function install_relevance_etc {
    backup ~/.relevance-etc
    ln -s $DOTFILES/submodules/relevance/etc $HOME/.relevance-etc
}

function install_org_mode {
    (
        cd $DOTFILES/.emacs.d
        if [ ! -d org-mode ]; then
            wget -O org-mode-master.zip \
                https://github.com/stuartsierra/org-mode/archive/master.zip
            unzip org-mode-master.zip
            mv org-mode-master org-mode
        fi
        cd org-mode
        make
    )
}

function install_magit {
    (
        cd $DOTFILES/.emacs.d
        if [ ! -d magit ]; then
            wget -O magit-1.2.0.tar.gz \
                https://github.com/magit/magit/archive/1.2.0.tar.gz
            tar xzf magit-1.2.0.tar.gz
            mv magit-1.2.0 magit
        fi
        cd magit
        make
    )
}

function compile_local_emacs {
    emacs -batch -f batch-byte-recompile-directory "$DOTFILES/.emacs.d/local"
}

