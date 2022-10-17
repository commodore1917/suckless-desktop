# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"

alias ls='ls --color=auto'
alias bm='bashmount'
alias sudo='doas'
# Alpine Linux
#alias xi='doas apk add'
#alias xu='doas apk -U upgrade'
#alias xr='doas apk del'
#alias xs='apk search'
# Void Linux
#alias xi='doas xbps-install -Syu'
#alias xu='doas xbps-install -Syu'
#alias xr='doas xbps-remove -R'
#alias xs='doas xbps-query -Rs'
