#!/bin/bash

########### Constants ###########
MODULES_LIST='modules.cfg'
MODULES_DIR='modules'


########## Utility functions #############
function ensure_modules_exists() {
    if [[ ! -d $MODULES_DIR ]]; then
        mkdir $MODULES_DIR
    fi
}


############ Single module operations ##########

function download_module() {
    name=$1
    url=`echo git@github.com:$name.git`
    mod_name=`echo $name | cut -d '/' -f 2`
    if [[ ! -d $mod_name ]]; then
        echo "_____ $mod_name _____"
        git clone --recursive $url
    fi
}

function install_module() {
    name=$1
    url=`echo git@github.com:$name.git`
    mod_name=`echo $name | cut -d '/' -f 2`
    cd $mod_name
    echo "_____ $mod_name _____"
    ../../pkg.sh install
    cd ..
}

function uninstall_module() {
    name=$1
    url=`echo git@github.com:$name.git`
    mod_name=`echo $name | cut -d '/' -f 2`
    cd $mod_name
    echo "_____ $mod_name _____"
    ../../pkg.sh uninstall
    cd ..
}

function update_module() {
    name=$1
    url=`echo git@github.com:$name.git`
    mod_name=`echo $name | cut -d '/' -f 2`
    cd $mod_name
    echo "_____ $mod_name _____"
    ../../pkg.sh update
    cd ..
}

############ Multi module operations ##########

function install_modules() {
    if [[ ! -f $MODULES_LIST ]]; then
        echo "No $MODULES_LIST found"
        exit 1
    fi
    if [[ $# -eq 0 ]]; then
        module_names=`cat $MODULES_LIST`
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
    module_names=`cat $MODULES_LIST`
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
        module_names=`cat $MODULES_LIST`
    else
        module_names=$@
    fi
    cd $MODULES_DIR
    for name in $module_names; do
        uninstall_module $name
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
        list_modules ;;
    'install')
        install_modules $cmd_args;;
    'update')
        update_modules ;;
    'uninstall')
        uninstall_modules $cmd_args ;;
    *)
        echo "Invalid command" ;;
esac

