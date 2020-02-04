#!/usr/bin/env bash

# This script is expected to sit in a directory above the emacs git repo
# with naming convention `build-emacs-${HOST}.sh`. It takes one argument,
# the emacs git branch to build, e.g. `master` or `emacs-27`.


me=$(realpath ${BASH_SOURCE:-$0})
here=${me%/*}
basename=$(basename ${me})

# error out with a message and status.
function _error {
    local msg=${1:-'error'}
    local status=${2:-1}
    echo ${msg} > /dev/stdout
    exit ${status}
}



# Extract the folder from the pathname for this script.
# Naming convention is `build-${git_root}-${HOST}.sh` where `git_root` is returned
#   by function folder.
function folder {
    local pathname=${1:?'expecting a pathname'}
    enforce=${2}
    if [[ ${pathname} =~ ^[^-]+-([^-]+)-.+ ]] ;
    then
        echo ${BASH_REMATCH[1]}
    else
        [[ -n "${enforce}" ]] && _error "folder in '${pathname}' not found"
    fi
}


repo=$(folder ${basename} 1)
branch=${1:-emacs-27}

cd ${repo}
starting_branch=$(git rev-parse --abbrev-ref HEAD)
# git stash ${branch} ${name}
git checkout ${branch}
build_branch=$(git rev-parse --abbrev-ref HEAD)

./autogen.sh
version=gh-$(git rev-parse HEAD)

prefix=/opt/${repo}
build_date=$(date +%F)
target=${prefix}/${repo}-${version}-${build_date}
./configure --prefix=${target}
make install

rrbb=${prefix}/${repo}-branch-${build_branch}
ln -sr ${target} ${rrbb}
rc=${prefix}/current
ln -sr ${target} ${rc}
echo "{install: {repo: '${repo}', target: '${target}', symlinks: ['${rrbb}', '${rc}']}}" >> /opt/${repo}/${repo}-install.history.log

git branch ${starting_branch}

