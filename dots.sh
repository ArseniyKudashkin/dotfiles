copyDir="$HOME/dotfiles/"

paths=(
	"$HOME/.config/alacritty/alacritty.toml"
	"$HOME/.config/nvim/init.lua"
	"/etc/pacman.conf"
	"$HOME/.bashrc"
	"/etc/X11/xorg.conf"
	"$HOME/.config/i3/config"
	"$HOME/.xinitrc"
    "$HOME/.config/hypr/hyprland.conf"
    "$HOME/.config/ranger/rc.conf"
    "$HOME/.config/nvim/bookmarks.db.json"
    "$HOME/.config/nvim/snippets/markdown.json"
    "$HOME/.config/nvim/snippets/package.json"
    "$HOME/.config/picom/picom.conf"
    "$HOME/.config/waybar/config.jsonc"
    "/etc/mkinitcpio.conf"
    "$HOME/.bash_profile"
    "$HOME/.config/musikcube/settings.json"
    "$HOME/.config/scripts/ms.conf"
    "$HOME/.config/electron-flags.conf"
    "$HOME/.config/gtk-3.0/settings.ini"
    "$HOME/.gtkrc-2.0"
    "$HOME/.icons/default/index.theme"
    "$HOME/.config/xsettingsd/xsettingsd.conf"
    "$HOME/.config/qt6ct/qt6ct.conf"
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
