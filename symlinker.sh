#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles directory
dir=~/dotfiles

# old dotfiles backup directory
olddir=~/dotfiles_old

# list of files/folders to symlink in homedir
home_files="gitconfig"
config_files="nvim"
suckless_src_files="dwm st dmenu slstatus"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles"
mkdir -p $olddir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $home_files; do
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
echo "done"

echo "Moving any existing config files from ~/.config to $olddir"
mkdir ~/.config
for file in $config_files; do
    mv ~/.config/$file $olddir
    echo "Creating symlink to $file in .local/src folder."
    ln -s $dir/$file ~/.config/$file
done
echo "done"

echo "Moving any existing src files from ~/.local/src to $olddir"
mkdir ~/.local/src
for file in $suckless_src_files; do
    mv ~/.local/src/$file $olddir
    echo "Creating symlink to $file in config folder."
    ln -s $dir/src/$file ~/.local/src/$file
done
echo "done"
