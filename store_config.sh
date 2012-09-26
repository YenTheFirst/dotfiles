function store_config() {
	if [ ! -e $1 ]
	then
		echo "$1 doesn't exist"
		return 1
	fi
	if [ -L $1 ]
	then
		echo "$1 is already a symlink!"
		return 2
	fi

	new_config_path="$HOME/dotfiles/`basename $1`"
	if [ -e new_config_path ]
	then
		echo "$new_config_path already exists"
		return 3
	fi

	#it should be safe to store this, then.
	mv $1 $new_config_path
	ln -s $new_config_path $1
}
