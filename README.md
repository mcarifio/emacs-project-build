# emacs-project-build

This repo is meant to be a [subrepo](https://github.com/ingydotnet/git-subrepo/) for [emacs](https://github.com/emacs-mirror/emacs). It provides some shell 
scripts and other conveniences to build emacs from sources fetched via git.

To use this git repo as a subrepo, do:

```bash
git_root=$(git rev-parse --show-toplevel)  # the root of the emacs git repo
cd ${git_root}
git subrepo clone https://github.com/mcarifio/emacs-project-build project/build -b prod
echo "/project-?*/**" >> ${git_root}/.git/info/exclude
export PATH="${git_root}/project/build/bin:${git_root}/project/build:$PATH" # optional
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
build-emacs-Ubuntu-eoan.sh
```

As I add more flavors, I create or modify these scripts.


To update the subtree:

```bash
git subrepo pull project/build
```


