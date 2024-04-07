#!/usr/bin/env bash

poly_dir="$HOME/.config/polybar/$RICETHEME"

# Set bspwm configuration for dattebayo
set_bspwm_config() {
    bspc config border_width 0
    bspc config top_padding 30
    bspc config bottom_padding 30
    bspc config left_padding 2
    bspc config right_padding 2
    bspc config normal_border_color "#1d1f28"
    bspc config active_border_color "#ff4c30"
    bspc config focused_border_color "#ff4c30"
    bspc config presel_feedback_color "#5adecd"
}

# Reload terminal colors
set_term_config() {
    sed -i "$HOME"/.config/alacritty/alacritty.toml \
        -e "s/opacity = .*/opacity = 0.6/g" \

    cat > "$HOME"/.config/alacritty/fonts.toml << EOF
[font]
size = 11

builtin_box_drawing = true

normal = { family = "ComicShannsMono Nerd Font", style = "Regular" }
bold = { family = "ComicShannsMono Nerd Font", style = "Bold" }
italic = { family = "ComicShannsMono Nerd Font", style = "Italic" }
bold_italic = { family = "ComicShannsMono Nerd Font", style = "Bold Italic" }
EOF

    cat > "$HOME"/.config/alacritty/rice-colors.toml << EOF
# Color scheme for ddat-tebayo Rice

# Default colors
[colors.primary]
background = "#282A36"
foreground = "#F8F8F2"

# Cursor colors
[colors.cursor]
cursor = "#8897F4"
text = "#1D1F28"

# Normal colors
[colors.normal]
black = "#3C3E4A"
blue = "#BD93F9"
cyan = "#8BE9FD"
green = "#50FA7B"
magenta = "#FF79C6"
red = "#FF5555"
white = "#BFBFBF"
yellow = "#F1FA8C"

# Bright colors
[colors.bright]
black = "#4D4D4D"
blue = "#CAA9FA"
cyan = "#9AEDFE"
green = "#5AF78E"
magenta = "#FF92D0"
red = "#FF6E67"
white = "#E6E6E6"
yellow = "#F4F99D"
EOF
}

# Set dunst notification daemon config
set_dunst_config() {
    sed -i "$HOME"/.config/punk_records/dunstrc \
        -e "s/transparency = .*/transparency = 9/g" \
        -e "s/frame_color = .*/frame_color = \"#1D1F28\"/g" \
        -e "s/separator_color = .*/separator_color = \"#8897F4\"/g" \
        -e "s/font = .*/font = ComicShannsMono Nerd Font 9/g" \
        -e "s/foreground='.*'/foreground='#79E6F3'/g"

    sed -i '/urgency_low/Q' "$HOME"/.config/punk_records/dunstrc
    cat >> "$HOME"/.config/punk_records/dunstrc <<- _EOF_
        [urgency_low]
        timeout = 3
        background = "#1D1F28"
        foreground = "#FDFDFD"

        [urgency_normal]
        timeout = 6
        background = "#1D1F28"
        foreground = "#FDFDFD"

        [urgency_critical]
        timeout = 0
        background = "#1D1F28"
        foreground = "#FDFDFD"
_EOF_
}

# Set eww colors
set_eww_colors() {
    cat > "$HOME"/.config/eww/colors.scss << EOF
// Eww colors for Shaka rice
\$bg: #1D1F28;
\$bg-alt: #1F222B;
\$fg: #FDFDFD;
\$black: #56687E;
\$lightblack: #262831;
\$red: #F37F97;
\$blue: #8897F4;
\$cyan: #79E6F3;
\$magenta: #B043D1;
\$green: #90ceaa;
\$yellow: #F2A272;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Shaka
set_jgmenu_colors() {
    sed -i "$HOME"/.config/punk_records/jgmenurc \
        -e 's/color_menu_bg = .*/color_menu_bg = #1D1F28/' \
        -e 's/color_norm_fg = .*/color_norm_fg = #a5b6cf/' \
        -e 's/color_sel_bg = .*/color_sel_bg = #1F222B/' \
        -e 's/color_sel_fg = .*/color_sel_fg = #a5b6cf/' \
        -e 's/color_sep_fg = .*/color_sep_fg = #56687E/'
}

# Set Rofi launcher config
set_launcher_config () {
    sed -i "$HOME/.config/rofi/Launcher.rasi" \
        -e '20s/\(font: \).*/\1"Terminess Nerd Font Mono Bold 10";/' \
        -e 's/\(background: \).*/\1#1D1F28;/' \
        -e 's/\(background-alt: \).*/\1#1D1F28E0;/' \
        -e 's/\(foreground: \).*/\1#c0caf5;/' \
        -e 's/\(selected: \).*/\1#6C77BB;/'

    # WallSelect menu colors
    sed -i "$HOME/.config/rofi/WallSelect.rasi" \
        -e 's/\(main-bg: \).*/\1#1D1F28BF;/' \
        -e 's/\(main-fg: \).*/\1#c0caf5;/' \
        -e 's/\(select-bg: \).*/\1#6C77BB;/' \
        -e 's/\(select-fg: \).*/\1#1D1F28;/'
}

# Launch the bar
launch_bars() {

    for mon in $(polybar --list-monitors | cut -d":" -f1); do
        (MONITOR=$mon polybar -q dat-1 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q dat-2 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q dat-3 -c "${poly_dir}"/config.ini)&
    done

}



### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_term_config
launch_bars
set_dunst_config
set_eww_colors
set_jgmenu_colors
set_launcher_config
