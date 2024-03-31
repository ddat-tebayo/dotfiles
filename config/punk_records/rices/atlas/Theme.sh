#!/usr/bin/env bash

poly_dir="$HOME/.config/polybar/$RICETHEME"

# Set bspwm configuration for Atlas
set_bspwm_config() {
    bspc config border_width 0
    bspc config top_padding 25
    bspc config bottom_padding 25
    bspc config left_padding 2
    bspc config right_padding 2
	bspc config normal_border_color "#4C3A6D"
	bspc config active_border_color "#4C3A6D"
	bspc config focused_border_color "#785DA5"
	bspc config presel_feedback_color "#070219"
}

# Reload terminal colors
set_term_config() {
    cat > "$HOME"/.config/alacritty/fonts.toml << EOF
[font]
size = 10

builtin_box_drawing = true

normal = { family = "Monocraft", style = "Regular" }
bold = { family = "Monocraft", style = "Bold" }
italic = { family = "Monocraft", style = "Italic" }
bold_italic = { family = "Monocraft", style = "Bold Italic" }
EOF

    cat > "$HOME"/.config/alacritty/rice-colors.toml << EOF
# (CyberPunk) Color scheme for Atlas Rice

# Default colors
[colors.primary]
background= '#070219'
foreground= '#c0caf5'

# Cursor colors
[colors.cursor]
cursor= '#C574DD' 
text= '#1D1F28'

# Normal colors
[colors.normal]
black=   '#070219'
red=     '#fb007a'
green=   '#a6e22e'
yellow=  '#f3e430'
blue=    '#58AFC2'
magenta= '#583794'
cyan=    '#926BCA'
white=   '#d9d9d9'

# Bright colors
[colors.bright]
black=   '#626483'
red=     '#fb007a'
green=   '#a6e22e'
yellow=  '#f3e430'
blue=    '#58AFC2'
magenta= '#472575'
cyan=    '#926BCA'
white=   '#f1f1f1'
EOF
}

# Set dunst notification daemon config
set_dunst_config() {
    sed -i "$HOME"/.config/punk_records/dunstrc \
		-e "s/transparency = .*/transparency = 8/g" \
		-e "s/frame_color = .*/frame_color = \"#070219\"/g" \
		-e "s/separator_color = .*/separator_color = \"#fb007a\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='#27fbfe'/g"

    sed -i '/urgency_low/Q' "$HOME"/.config/punk_records/dunstrc
    cat >> "$HOME"/.config/punk_records/dunstrc <<- _EOF_
        [urgency_low]
		timeout = 3
		background = "#070219"
		foreground = "#27fbfe"

		[urgency_normal]
		timeout = 6
		background = "#070219"
		foreground = "#27fbfe"

		[urgency_critical]
		timeout = 0
		background = "#070219"
		foreground = "#27fbfe"
_EOF_
}

# Set eww colors
set_eww_colors() {
    cat > "$HOME"/.config/eww/colors.scss << EOF
// Eww colors for Atlas rice
\$bg: #070219;
\$bg-alt: #09021f;
\$fg: #c0caf5;
\$black: #626483;
\$lightblack: #262831;
\$red: #fb007a;
\$blue: #58AFC2;
\$cyan: #926BCA;
\$magenta: #583794;
\$green: #a6e22e;
\$yellow: #f3e430;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Atlas
set_jgmenu_colors() {
    sed -i "$HOME"/.config/punk_records/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #070219/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #c0caf5/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #09021f/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #c0caf5/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #626483/'
}

# Set Rofi launcher config
set_launcher_config () {
    sed -i "$HOME/.config/rofi/Launcher.rasi" \
        -e '20s/\(font: \).*/\1"Monocraft 10";/' \
		-e 's/\(background: \).*/\1#070219F0;/' \
		-e 's/\(background-alt: \).*/\1#070219E0;/' \
		-e 's/\(foreground: \).*/\1#c0caf5;/' \
		-e 's/\(selected: \).*/\1#fb007af0;/' \

    # WallSelect menu colors
    sed -i "$HOME/.config/rofi/WallSelect.rasi" \
		-e 's/\(main-bg: \).*/\1#070219F0;/' \
		-e 's/\(main-fg: \).*/\1#c0caf5;/' \
		-e 's/\(select-bg: \).*/\1#fb007a;/' \
		-e 's/\(select-fg: \).*/\1#070219;/'
}

# Launch the bar
launch_bars() {

    for mon in $(polybar --list-monitors | cut -d":" -f1); do
        (MONITOR=$mon polybar -q atlas1 -c "${poly_dir}"/config.ini)&
        (MONITOR=$mon polybar -q atlas2 -c "${poly_dir}"/config.ini)&
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
