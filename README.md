# emacs-project-build

This repo is meant to be a [subrepo](https://github.com/ingydotnet/git-subrepo/) for [emacs](https://github.com/emacs-mirror/emacs). It provides some shell 
scripts and other conveniences to build emacs from sources fetched via git.

To use this git repo as a subrepo, do:

```bash
cd $(git rev-parse --show-toplevel) # the root of the emacs git repo
git subrepo clone https://github.com/mcarifio/emacs-project-build project/build -b prod
```

This should create a local file tree that looks like:

```bash
── emacs/

...

├── project/
│   └── build/
│       ├── build-emacs-Ubuntu-eoan.sh*
│       ├── README.md
│       ├── utils.env.sh
│       └── ...

...

```

To build emacs for various (newer) Linux flavors:

```
./project/build/build-emacs-Ubuntu-eoan.sh
```

As I add more flavors, I create or modify these scripts.


To update the subtree:

```bash
git subrepo pull project/build
```


