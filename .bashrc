date +%H:%M:%S,\ %d\|%m\|%y

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias \
	ls='ls --color=auto' \
	grep='grep --color=auto' \
	vicfg='nvim ~/.config/nvim/init.lua' \
	vi='nvim' \
	upd='sudo pacman -Syyuu' \
	get='sudo pacman -S' \
	exercism='~/bin/exercism' \
	es='exercism submit *.sh' \
	tsk='nvim main.sh' \
	gits='git status --untracked-files=no' \
	dm='~/dm.sh' \
	ms='~/ms.sh' \
    vis="sudo -E nvim" \
    vin="nvim ~/openNotes/Ar/main.md" \
    vic="nvim ~/.config/nvim/init.lua" \
    1cdnvim="cd /home/ikillmylinux/.config/nvim/" \
    1aliases="nvim /home/ikillmylinux/.bashrc" \
    i3cfg="nvim ~/.config/i3/config" \


set -o vi
PS1='[\u@\h \W]\$ '
