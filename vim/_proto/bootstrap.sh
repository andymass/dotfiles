#!/usr/bin/bash

function syncrepo() {
    if [ -d "$2" ]
    then
        ( cd "$2" && git pull )
    else
        git clone "$1" "$2" 
    fi
}

github=https://github.com

syncrepo $github/tpope/vim-pathogen.git bundle.avail/vim-pathogen
syncrepo $github/junegunn/vim-plug.git  bundle.avail/vim-plug

