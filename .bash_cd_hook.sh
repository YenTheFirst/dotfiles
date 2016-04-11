#on every call, sees if the working directory has changed. if so, call the post-cd hooks
#using this method, instead of overriding builtin cd, so it plays better with things like rvm
function check_cd()
{
  if [ "$LAST_PWD" != "$PWD" ]; then
    post_cd_hooks
  fi
  LAST_PWD=$PWD
}

function post_cd_hooks()
{
  set_local_histfile
  set_virtualenv
}

function set_local_histfile()
{
  #history -w # write current history file
  local HISTDIR="$HOME/.bash_history.d$PWD" # use nested folders for history
  if [ ! -d "$HISTDIR" ]; then # create folder if needed
    mkdir -p "$HISTDIR"
  fi
  export HISTFILE="$HISTDIR/${USER}_bash_history.txt" # set new history file
  history -c #clear memory
  history -r #read from current histfile
}

function set_virtualenv()
{
  # if we're entering a project directory, check for a virtualenv
  this_dir=$(basename "$PWD")
  parent_dir=$(dirname "$PWD")
  if [ "$parent_dir" == "$HOME" ]; then
    if [ -d "$HOME/env/${this_dir}" ]; then
      echo "Activating virtualenv: $this_dir..."
      source "$HOME/env/${this_dir}/bin/activate"
    fi
  fi
}
