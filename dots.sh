copyDir="$HOME/dotfiles/"

paths=(
	"$HOME/.config/alacritty/alacritty.toml"
	"$HOME/.config/nvim/init.lua"
	"/etc/pacman.conf"
	"$HOME/.bashrc"
	"/etc/X11/xorg.conf"
	"$HOME/.config/i3/config"
	"$HOME/.xinitrc"
)


main()
{
    homeLen=${#HOME}+1

    for (( i=0;i<${#paths[@]};i++ )); do
        if [[ ${paths[i]} =~ "$HOME" ]]; then
            mkdir -p "$(dirname "${paths[i]:$homeLen}")"
            cp "${paths[i]}" "$(dirname "${paths[i]:$homeLen}")"
        elif [[ "${paths[i]}" =~ "/etc/" ]]; then
            mkdir -p "$(dirname "${paths[i]:1}")"
            cp "${paths[i]}" "$(dirname "${paths[i]:1}")"
        fi
    done

   return 0
}

main "$@"
