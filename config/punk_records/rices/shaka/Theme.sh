#!/usr/bin/env bash

poly_dir="$HOME/.config/polybar/$RICETHEME"

# Set bspwm configuration for Shaka
set_bspwm_config() {
    bspc config border_width 0
    bspc config top_padding 45
    bspc config bottom_padding 0
    bspc config left_padding 2
    bspc config right_padding 2
    bspc config normal_border_color "#8897F4"
    bspc config active_border_color "#8897F4"
    bspc config focused_border_color "#C574DD"
    bspc config presel_feedback_color "#FF4971"
}

# Reload terminal colors
set_term_config() {
    cat > "$HOME"/.config/alacritty/fonts.toml << EOF
[font]
size = 10

builtin_box_drawing = true

normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
bold = { family = "JetBrainsMono Nerd Font", style = "Bold" }
italic = { family = "JetBrainsMono Nerd Font", style = "Italic" }
bold_italic = { family = "JetBrainsMono Nerd Font", style = "Bold Italic" }
EOF

    cat > "$HOME"/.config/alacritty/rice-colors.toml << EOF
# Color scheme for Shaka Rice

# Default colors
[colors.primary]
background = "#1D1F28"
foreground = "#FDFDFD"

# Cursor colors
[colors.cursor]
cursor = "#8897F4"
text = "#1D1F28"

# Normal colors
[colors.normal]
black = "#3D4C5F"
blue = "#8897F4"
cyan = "#79E6F3"
green = "#5ADECD"
magenta = "#C574DD"
red = "#F37F97"
white = "#FDFDFD"
yellow = "#F2A272"

# Bright colors
[colors.bright]
black = "#56687E"
blue = "#556FFF"
cyan = "#3FDCEE"
green = "#18E3C8"
magenta = "#B043D1"
red = "#FF4971"
white = "#BEBEC1"
yellow = "#FF8037"
EOF
}

# Set dunst notification daemon config
set_dunst_config() {
    sed -i "$HOME"/.config/punk_records/dunstrc \
        -e "s/transparency = .*/transparency = 9/g" \
        -e "s/frame_color = .*/frame_color = \"#1D1F28\"/g" \
        -e "s/separator_color = .*/separator_color = \"#8897F4\"/g" \
        -e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
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
        (MONITOR=$mon polybar -q shaka1 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q shaka2 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q shaka3 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q shaka4 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q shaka5 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q shaka6 -c "${poly_dir}"/config.ini)&
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
