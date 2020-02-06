# error out with a message and status.
error() {
    local msg=${1:-'error'}
    local status=${2:-1}
    echo ${msg} > /dev/stdout
    exit ${status}
}


# Extract the folder from the pathname for this script.
# Naming convention is `build-${git_root}-${HOST}.sh` where `git_root` is returned
#   by function folder.
folder() {
    local pathname=${1:?'expecting a pathname'}
    enforce=${2}
    if [[ ${pathname} =~ ^[^-]+-([^-]+)-.+ ]] ;
    then
        echo ${BASH_REMATCH[1]}
    else
        [[ -n "${enforce}" ]] && _error "folder in '${pathname}' not found"
    fi
}

