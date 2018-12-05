#!/bin/bash

########### Constants ###########
MODULES_LIST='modconfig.sh'
MODULES_DIR='modules'
source $MODULES_LIST

########## Utility functions #############
function ensure_modules_exists() {
    if [[ ! -d $MODULES_DIR ]]; then
        mkdir $MODULES_DIR
    fi
}

function url_to_name() {
    url=$1
    if echo $url | grep -q 'git@.*\.git' - ; then
        name=`echo $url | cut -d '/' -f 2 | sed 's/.git//'`
        echo $name
    else
        echo $url
    fi
}


############ Single module operations ##########

function download_module() {
    url=$1
    name=`url_to_name $url`
    if [[ ! -d $name ]]; then
        echo "_____ $name _____"
        git clone --recursive $url
    fi
}

function install_module() {
    url=$1
    name=`url_to_name $url`
    cd $name
    echo "_____ $name _____"
    ../../pkg.sh install
    cd ..
}

function uninstall_module() {
    url=$1
    name=`url_to_name $url`
    cd $name
    echo "_____ $name _____"
    ../../pkg.sh uninstall
    cd ..
}

function update_module() {
    url=$1
    name=`url_to_name $url`
    cd $name
    echo "_____ $name _____"
    ../../pkg.sh update
    cd ..
}

function run_git_cmd() {
    url=$1
    name=`url_to_name $url`
    args=$@
    git_args=("${args[@]:1}")
    cd $name
    echo "_____ $name _____"
    git $git_args
    cd ..
}

############ Multi module operations ##########

function install_modules() {
    if [[ ! -f $MODULES_LIST ]]; then
        echo "No $MODULES_LIST found"
        exit 1
    fi
    if [[ $# -eq 0 ]]; then
        module_names=${enabled_modules[@]}
    else
        module_names=$@
    fi
    ensure_modules_exists
    cd $MODULES_DIR
    for name in $module_names; do
        download_module $name
        install_module $name
    done
    cd ..
}


function update_modules() {
    ensure_modules_exists
    module_names=${enabled_modules[@]}
    cd $MODULES_DIR
    for name in $module_names; do
        update_module $name
    done
    cd ..
}

function uninstall_modules() {
    if [[ ! -d $MODULES_DIR ]]; then
        echo "No modules present"
        exit 1
    fi
    if [[ $# -eq 0 ]]; then
        module_names=${enabled_modules[@]}
    else
        module_names=$@
    fi
    cd $MODULES_DIR
    for name in $module_names; do
        uninstall_module $name
    done
    cd ..

}

function recursive_git() {
    if [[ ! -d $MODULES_DIR ]]; then
        echo "No modules present"
        exit 1
    fi
    module_names=${enabled_modules[@]}
    cd $MODULES_DIR
    for name in $module_names; do
        run_git_cmd $name $@
    done
    cd ..

}

function list_modules() {
    if [[ ! -d $MODULES_DIR ]]; then
        echo "No modules present"
        exit 1
    fi
    if [[ `ls $MODULES_DIR | wc -l` -eq 0 ]]; then
        echo "No $MODULES_DIR present"
    else
        ls $MODULES_DIR
    fi
}

function show_modules_info() {
    if [[ ! -d $MODULES_DIR ]]; then
        echo "No modules present"
        exit 1
    fi
    cd $MODULES_DIR
    echo "Currently installed modules:"
    for module in `ls`; do
        cd $module
        echo "_____ $module _____"
        ../../pkg.sh info
        ../../pkg.sh show-links
        cd ..
    done
    cd ..
}


############ Main entry ############

args=("$@")
cmd_args=("${args[@]:1}")

if [[ $# -eq 0 ]]; then
    subcommand='info'
else
    subcommand=$1
fi

case $subcommand in
    'info')
        show_modules_info ;;
    'install')
        install_modules $cmd_args;;
    'update')
        update_modules ;;
    'uninstall')
        uninstall_modules $cmd_args ;;
    'git')
        recursive_git $cmd_args ;;
    *)
        echo "Invalid command" ;;
esac

