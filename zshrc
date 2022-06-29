# Lines configured by zsh-newuser-install
HISTFILE=~/cache/histfile
HISTSIZE=10000
SAVEHIST=10000

autoload -U colors && colors
setopt autocd extendedglob nomatch
unsetopt beep notify

PROMPT='%B%F{white}[%n%f%b %F{white}%2~%f%B%F{white}]%b%f %F{green}$%f '

bindkey -v
zstyle :compinstall filename '/home/ross/.zshrc'

autoload -Uz compinit
compinit

alias ls="ls -l --color=auto"
