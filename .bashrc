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
	gits='git status --untracked-files=no' \
	dm='~/sync/scripts/dm.sh' \
	ms='~/sync/scripts/ms.sh' \
    sm="sudo -E ~/sync/scripts/sm.sh" \
    smcfg="nvim ~/.config/scripts/systemManagementOptions.conf" \
    vis="sudo -E nvim" \
    vin="nvim ~/openNotes/Ar/main.md" \
    vic="nvim ~/.config/nvim/init.lua" \
    cdnvim="cd /home/ikillmylinux/.config/nvim/" \
    aliases="nvim /home/ikillmylinux/.bashrc" \
    i3cfg="nvim ~/.config/i3/config" \
    gety="yay -S" \
    ref="sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syyuu" \
    cal="export LC_TIME=ru_RU.UTF-8 && cal -3 && unset LC_TIME" \
    wip="cd $HOME/sync/scripts/wip && nvim main.sh" \
	tsk='nvim main.sh' \
    run='./main.sh' \
    wkill="hyprctl kill" \
    gm="$HOME/sync/scripts/gm.sh" \
    links="$HOME/sync/scripts/links.sh" \
    mc="cd /home/ikillmylinux/.local/share/PrismLauncher/instances/" \
    st="cd /home/ikillmylinux/.local/share/Steam/steamapps/common/" \

set -o vi
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2024-12-23 21:54:33
export PATH="$PATH:/home/ikillmylinux/.local/bin"
