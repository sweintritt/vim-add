#!/bin/bash

ORIGINPATH=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
CONFIG=${HOME}/.vim_add
IGNORES="^#|^$"
BUNDLE_DIR=$HOME/.vim/bundle

# $1 installed
_vim-add-get-plugins() {
    names="all"

    while read -r plugin; do
        name=${plugin##*/}

        if [ "$name" == "vim-pathogen" ]; then
            if [ -f $AUTOLOAD_DIR/pathogen.vim ] && [ $BUNDLE_DIR/vim-pathogen/autoload/pathogen.vim ]; then
                if [ "$1" == "installed" ]; then
                    names="$names $name"
                fi
            else
                if [ "$1" == "not-installed" ]; then
                    names="$names $name"
                fi
            fi
        else
            if [ -d ${BUNDLE_DIR}/$name ]; then
                if [ "$1" == "installed" ]; then
                    names="$names $name"
                fi
            else
                if [ "$1" == "not-installed" ]; then
                    names="$names $name"
                fi
            fi
        fi
    done < <(egrep -v "${IGNORES}" ${CONFIG})
    echo "$names"
}

_vim-add-completion() {
    COMPREPLY=()
    if [ "${#COMP_WORDS[@]}" == "2" ]; then
        COMPREPLY=( $( compgen -W "add delete help install remove status update version" -- "${COMP_WORDS[COMP_CWORD]}" ))
    elif [ "${#COMP_WORDS[@]}" == "3" ]; then
        case "${COMP_WORDS[1]}" in
            add)     names=""
                     ;;
            delete)  names=$(_vim-add-get-plugins "installed")
                     ;;
            help)    names=""
                     ;;
            install) names=$(_vim-add-get-plugins "not-installed")
                     ;;
            remove)  names=$(_vim-add-get-plugins "installed")
                     ;;
            status)  names=""
                     ;;
            update)  names=$(_vim-add-get-plugins "installed")
                     ;;
            version) names=""
                     ;;
        esac
        COMPREPLY=( $( compgen -W "$names" -- "${COMP_WORDS[COMP_CWORD]}" ))
    fi

    return 0
}

complete -F _vim-add-completion vim-add
