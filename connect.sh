_main() {
    local here=${BASH_SOURCE%/*}
    local root=$(git -C ${here} rev-parse --show-toplevel)
    local parent=$(git -C ${root}/.. rev-parse --show-toplevel)
    local relpath=$(realpath ${root} --relative-to=${parent})

    echo -e "# added by '${BASH_SOURCE}' on '$(date)'\n/${relpath}/**" >> ${parent}/.git/info/exclude
    PATH="${here}/bin:$PATH"
}

_main()
unset _main
