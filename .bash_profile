#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    Hyprland
    # startx
fi

export PATH=$PATH:/home/ikillmylinux/.millennium/ext/bin

# Created by `pipx` on 2024-12-23 21:54:33
export PATH="$PATH:/home/ikillmylinux/.local/bin"
