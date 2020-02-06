# emacs-project-build

This repo is meant to be a "child repo" for [emacs](https://github.com/emacs-mirror/emacs). It provides some shell 
scripts and other conveniences to build emacs from sources fetched via git.

To use it, run these commands at the root of your emacs clone:

```bash
git clone --branch=prod https://github.com/mcarifio/emacs-project-build $(git rev-parse --show-toplevel)/project/build
source project/build/connect.sh
```

This should create a local file tree that looks like:

```bash
── emacs/

...

├── project/
│   └── build/bin/
│       ├── build-emacs-Ubuntu-eoan.sh*
│       ├── README.md
│       ├── utils.env.sh
│       └── ...

...

```

To build emacs for various (newer) Linux flavors:

```
./project/build/bin/build-emacs-Ubuntu-eoan.sh
# or
build-emacs-Ubuntu-eoan.sh
```

As I add more flavors, I'll create or modify the various scripts.


To update the child:

```bash
git -C project/build pull
```


