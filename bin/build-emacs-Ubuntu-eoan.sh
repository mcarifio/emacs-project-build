#!/usr/bin/env bash

# This script is expected to sit in a directory below the emacs git repo
# with naming convention `build-emacs-$(lsb_release -ic)-$(lsb_release -sc).sh`,
# for example `build-emacs-Ubuntu-eoan.sh`.
# It takes one argument, the emacs git branch||tag to build, e.g. `master` or `emacs-27`.

# This script does "just enough" to build from sources and install at the "prefix" location below.
# There are many ways to build software (make/gmake, etc.) and there are dozens of build tools.
# This isn't an exercise is buildology, it's just one set of conventions to build emacs from sources.

# See `./README` for how to use this script (and others).


me=$(realpath ${BASH_SOURCE:-$0})
here=${me%/*}
source ${here}/utils.env.sh

project_subtree_root=$(git -C ${here} rev-parse --show-toplevel)
project_root=$(git -C ${project_subtree_root}/.. rev-parse --show-toplevel)
basename=$(basename ${project_root})
repo=${basename}
branch=${1:-emacs-27}


# A hack. Move up to the project root to simplify commands.
cd ${project_root}
starting_branch=$(git rev-parse --abbrev-ref HEAD)
# git stash ${branch} ${name}
git checkout ${branch}
build_branch=$(git rev-parse --abbrev-ref HEAD)

./autogen.sh
version=gh-$(git rev-parse HEAD)

prefix=${PREFIX:-/opt/${repo}}
build_date=$(date +%F)
target=${prefix}/${repo}-${version}-${build_date}
./configure --prefix=${target}
make install

rrbb=${prefix}/${repo}-branch-${build_branch}
ln -sr ${target} ${rrbb}
rc=${prefix}/current
ln -sr ${target} ${rc}
echo "{install: {repo: '${repo}', target: '${target}', symlinks: ['${rrbb}', '${rc}']}}" >> ${prefix}/${repo}-install.history.log

git branch ${starting_branch}

