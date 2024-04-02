#!/usr/bin/env bash

poly_dir="$HOME/.config/polybar/$RICETHEME"

# Set bspwm configuration for Edison
set_bspwm_config() {
    bspc config border_width 0
    bspc config top_padding 2
    bspc config bottom_padding 40
    bspc config left_padding 2
    bspc config right_padding 2
	bspc config normal_border_color "#414868"
	bspc config active_border_color "#c0caf5"
	bspc config focused_border_color "#bb9af7"
	bspc config presel_feedback_color "#7aa2f7"
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
# Color scheme for Edison Rice

# Default colors
[colors.primary]
background = "#1D1F28"
foreground = "#FDFDFD"

# Cursor colors
[colors.cursor]
cursor = "#00ff5e"
text = "#1a1b26"

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
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"#14171c\"/g" \
		-e "s/separator_color = .*/separator_color = \"#abb2bf\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='#7560d3'/g"

    sed -i '/urgency_low/Q' "$HOME"/.config/punk_records/dunstrc
    cat >> "$HOME"/.config/punk_records/dunstrc <<- _EOF_
        [urgency_low]
        timeout = 3
        background = "#14171c"
        foreground = "#b8bfe5"

        [urgency_normal]
        timeout = 6
        background = "#14171c"
        foreground = "#b8bfe5"

        [urgency_critical]
        timeout = 0
        background = "#14171c"
        foreground = "#b8bfe5"
_EOF_
}

# Set eww colors
set_eww_colors() {
    cat > "$HOME"/.config/eww/colors.scss << EOF
// Eww colors for Edison rice
\$bg: #14171c;
\$bg-alt: #181b21;
\$fg: #b8bfe5;
\$black: #5c6370;
\$lightblack: #262831;
\$red: #be5046;
\$blue: #4889be;
\$cyan: #49919a;
\$magenta: #7560d3;
\$green: #81ae5f;
\$yellow: #d19a66;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Edison
set_jgmenu_colors() {
    sed -i "$HOME"/.config/punk_records/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #14171c/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #b8bfe5/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #181b21/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #b8bfe5/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #5c6370/'

}

# Set Rofi launcher config
set_launcher_config () {
    sed -i "$HOME/.config/rofi/Launcher.rasi" \
		-e '22s/\(font: \).*/\1"Terminess Nerd Font Mono Bold 10";/' \
		-e 's/\(background: \).*/\1#14171c;/' \
		-e 's/\(background-alt: \).*/\1#14171cE0;/' \
		-e 's/\(foreground: \).*/\1#b8bfe5;/' \
		-e 's/\(selected: \).*/\1#8677cf;/' \

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
        (MONITOR=$mon polybar -q edi1 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q edi2 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q edi3 -c "${poly_dir}"/config.ini)&
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
