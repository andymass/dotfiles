#!/usr/bin/bash

# setup
SCRIPT=$(realpath "$0")
DOTDIR=$(dirname "$SCRIPT")

DRY=echo

function makelink() {
    $DRY ln -sv "$DOTDIR/$1" "$2"
}
function makedir() {
    $DRY mkdir -pv "$1"
}
function copyproto() {
    if [ -d "$2" ]
    then
        $DRY "destination '$2' exists"
    else
        $DRY cp -anr "$DOTDIR/$1/_proto" "$2"
    fi
}
function run() {
    $DRY "$@"
}
function showusage() {
    echo "usage: $(basename "$SCRIPT") [-fh]"
    echo "       -f    no dry run"
    echo "       -h    usage"
}

# start
while :; do
    case $1 in
        -f)
            DRYRUN=
            ;;
        -h|-\?|--help)
            showusage
            exit
            ;;
        *)
            break
            ;;
    esac
    shift
done

if [ -n "$DRY" ]
then
    echo "dry run: pass -f to run"
fi

# git
makelink git/gitconfig ~/.gitconfig
makelink git/gitignore ~/.gitignore

# tmux
makelink tmux/tmux.conf ~/.tmux.conf

# vim
VIMDEST=$HOME/.vim

copyproto vim "$VIMDEST"
makelink '.' "$VIMDEST/dots" 
run "$VIMDEST/bootstrap.sh"

# makelink vim/config "$VIMDEST/config" 
# makelink vim/vimrc  "$VIMDEST/vimrc" 
# makedir "$VIMDEST"
# install -Dm644 "$DOTDIR/vim/bundle.avail"  "$VIMDEST/bundle.avail"
# makedir "$VIMDEST/autoload"

# zsh
makelink zsh/zshrc ~/.zshrc
makelink zsh/zshenv ~/.zshenv

