#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    # Hyprland
    startx
fi

export PATH=$PATH:/home/ikillmylinux/.millennium/ext/bin
