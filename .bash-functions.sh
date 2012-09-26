# Usage: mycd <path>
#
# Replacement for builtin 'cd', which keeps a separate bash-history
# for every directory.
function mycd()
{
  history -w # write current history file
  builtin cd "$@" # do actual cd
  local HISTDIR="$HOME/.bash_history.d$PWD" # use nested folders for history
  if [ ! -d "$HISTDIR" ]; then # create folder if needed
    mkdir -p "$HISTDIR"
  fi
  export HISTFILE="$HISTDIR/${USER}_bash_history.txt" # set new history file
  history -c # clear memory
  history -r #read from current histfile

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
