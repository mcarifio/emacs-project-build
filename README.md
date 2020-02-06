# emacs-project-build

## Summary

This repo is meant to be a "child repo" for [emacs](https://github.com/emacs-mirror/emacs). 
It provides some shell  scripts and other conveniences to build emacs from sources fetched via git.

## Setup

To use it, run these commands at the root of your emacs clone:

```bash
git clone --branch=prod https://github.com/mcarifio/emacs-project-build $(git rev-parse --show-toplevel)/project/build
source project/build/connect.sh
```

The first command should append a subtree that looks like:

```bash
└── emacs/

...

    ├── project/
    │   └── build/
    │       ├── bin/
    │       │   ├── build-emacs-Ubuntu-eoan.sh*
    │       │   └── utils.env.sh
    │       ├── connect.sh
    │       └── README.md
    ├── README
    ├── src/

...

```

The second command `connect.sh` should "connect" the two trees together:

* git should treat `project/build` as something the parent should _not_ commit

* bash should utilize the scripts in `project/build/bin` to simplify the emacs build.


## Usage

To build emacs for various (newer) Linux flavors:

```
./project/build/bin/build-emacs-Ubuntu-eoan.sh
# or
build-emacs-Ubuntu-eoan.sh
```

The scripts are named `build-${repo}-${platform}-${version}.sh`. Here's a generic way to run them:

```bash
repo=$(basename $(git rev-parse --show-toplevel)) # emacs
platform=$(lsb_release -ic)  # Ubuntu
version=$(lsb_release -sc) # eoan
build=build-${repo}-${platform}-${version}.sh # build-emacs-Ubuntu-eoan.sh
${build}
```


To update the child:

```bash
git -C project/build pull
```

To update all the children:

```bash
for d in $(find ./project -name .git -type d -printf '%h') ; do git -C ${d} pull ; done
```



If you have `direnv` installed, you can "connect.sh" every time you cd to the parent directory:

```bash
echo '[[ -f project/build/connect.sh ]] && source project/build/connect.sh' >> .envrc
direnv allow .envrc
```
