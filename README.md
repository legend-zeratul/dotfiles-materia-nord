# dotfiles-materia-nord. Dotfiles with a collection of 'unified' nord schemes for a polished XFCE desktop.

MIT License. Legend Zeratul.

A collection of dotfiles, configurations for most typical linux apps with a 'unified', but pragmatic Nord look - based on the excellent 'Nord' color theme/palette.

## 1. Overview ##

### Principles ### 
- Should result in a minimal, unified, polished desktop experience
- Dont fix what aint broken
- Minimal number of installations/tools
- Should be modular/customizable (people can take/adapt what they chose to/what they like)
- Least constraints - those who like a terminal should be at home, so should those who prefer a mouse
- Pragmatic use of the color theme - sites/documents will continue to be white, code/terminals can follow the 'cool/dark' look
- Unified/selected fonts -> with both GTK/WM color theme -> and wallpapers
- More than the amount of time spent customizing the user interface, this theme is about saving you time in getting to a polished, minimal 'Nord' look
- Since the dependencies are low, the theme is surprisingly independent of distro/DE - and can be used on any distro/DE you have in mind (the theme was built on the excellent EndeavourOS - my distro of choice)

The result:
![Screenshot](images-screenshots/screenshot-4d.png?raw=true "Screenshot")

### Disclaimers/Ownership ###
- I'm not the creator of the Nord color scheme - more details, creator/owner here: https://www.nordtheme.com/
- I'm not the original author of any of the wallpapers - I have a collection that has grown over time from a diverse collection of sources, I dont keep track of the source of the originals (you can find multiple sources for the originals). I've run the images through the image-go-nord script to result in a colorized version that aligns to the desktop theme.. Its those colorized versions that are included here. If you are the owner of any of the originals behind the wallpapers included here, and would either prefer that I attach a link to your version also, or remove the colorized version from this repository, pls message, will do so.
- I did create the Materia-Nordic colorised theme, I did create the Conky dials and the workspace indicators from scratch - these are my own customizations/implementations. I will be reaching out to the Materia theme owners to see if they are interested in keeping/maintaining an official 'Nord' version - will post an update.

### Components/Whats included ###
- Nord themes for terminals and editors - alacritty, Tilix, nvim, gEdit, xed
- My conky/eww (pager), and quicktile configuration (including an eww binary built on EndeavourOS)
- Source, color theme to 'Nordify' the excellent Materia-GTK theme (without making the entire theme dark)
- Picom (Kawase blur) conf with exceptions for Conky, eww
- White bar icons (original owner: https://www.deviantart.com/txusmetal4ever/art/White-Flat-Taskbar-Icons-692863969), I've added the Terminal prompt icon - only the Terminal prompt is included - you can get the others from the link

### Components/Things to install (I've not changed these) ###
- Nord themes for Sublime Text and VS Codium can be installed through their plugin manager
- Spotify client/Dribblish themes can be done through AUR/APT
- Alacritty, Tilix, Neovim, etc - base packages to be installed from their respective repositories - you should have most of these already installed
- Install wmctrl (if not already installed - needed for clicking the workspaces indicator to switch)

## 2. Installation ##

### Installation Steps ###
- Install the Fonts - Inter, Agave, Mononoki and Font Awesome. [I originally wanted to include these - including the fonts would have made the package complete - however, I've not changed them, so I wasnt sure that I'm allowed to, I chose not to], URLs for these are given below:
  - Inter (default UI font): https://github.com/rsms/inter/
  - Agave (Editor font): https://b.agaric.net/page/agave
  - Mononoki (Terminal font): https://www.nerdfonts.com/font-downloads (I found Agave and Mononoki from the Nerd Fonts Repository (last URL))
  - Font Awesome (needed for the workspace indicator): https://use.fontawesome.com/releases/v5.15.2/fontawesome-free-5.15.2-desktop.zip
  (Install the above using either the package manager or by copying them to ```~/.fonts```)
- Extract the contents of this repo to a local folder
- Install the optipng, bc and sassc packages (```yay -S optipng bc sassc```) (needed for the next step)
- Change to the theme-materia-nord folder, and run ```./change_color.sh -o Materia-Nordic theme-materia-nordic-2.conf``` to create/install the materia-nordic theme
- Copy the contents of the dotfiles folder to your home directory - this should get you the needed color themes for the editors/terminals/GTK, and the conky/eww configs to the respective directories
- Conky: the dials script needs Lua and Cairo: install lua5.4 first, followed by the conky-cairo (Arch) or conky-all (Debian/Ubuntu) packages

### Verify ###
- The eww workspace indicator requires either a pre-built eww (following the instructions from: ) - or you can use the included eww binary (assuming that works for your machine/distro)
- Run ```~/.config/.utils/eww-widgets/eww --help``` - to check if the built eww binary works on your machine.
- Run ```conky -v``` to check that the Lua/Cairo bindings work fine. If you see the below output in the console, you should be good:

~~~
Lua bindings:
  * Cairo
  * Imlib2
  * RSVG
~~~

- I've kept the repository for the conky dials separate (I can evolve them separately) - if you are interested in customizing them - further instructions are at: https://github.com/legend-zeratul/conky-dials

- The eww workspaces indicator assumes that you have 6 workspaces - this will be a distro/DE specific config - if you want to use lesser/more, change the scripts under ```.config/eww```

- Change to the .config folder, and start enabling the tested components (move the resp .desktop files from ```.config/autostart-disabled``` to ```.config/autostart```)
- Logout/Log back in - and if everything went well, the theme should be applied across.

## 3. Others ##
### Tiling Configuration ###
My tiling config is setup for my workflow, and possibly different from what a tiling WM like i3 or Awesome would do.. 

#### Main differences for my workflow ####
- Workspace specific tiling config (Workspace 1 is always browser, other maximized windows) - if using i3, this workspace would most likely be tabbed, not tiled
- Workspaces 5,6 are meant for Teams/Virtual Desktop - again floating/maximized configs instead of tiled
- Workspaces 2,3 and 4 typically used a 2x2 tile - for most cases - and will have a mix of text editors/terminals - exact layout config will depend on what I'm working on.. VSCodium will get maximized (terminals flow over to the next desktop), Sublime text gets half-the workspace, the right side being taken up by a Terminal
- When working on Sublime Text/Terminal combo, screen layout gets split 60-40 (and not 50-50)
- I tend to decide the tiling config _after opening the window, not always statically set_ - in other words, a keyboard shortcut to decide the config after opening the window works better for my workflow
- Terminal multiplexing is sorted thanks to tmux.. I can always open other alacritty windows if needed
- Dialog windows are always floating, and should not change the already open windows

I had tried i3 before, but it didnt exactly work like the layout described above, I could achieve most of the above (except the 60-40 split) with simple XFWM4 tiling. Keeping in mind the 'minimal change' principle, I decided to add quicktile only for the 60-40 scenario.

#### My current workflow works like this ####
- L->R - either maximize the window for the entire desktop - or tile left/tile right - this gets me a list of vertical windows placed next to each other - horizontal workspaces, obviously..
- Tile L/R/T/D is managed by XFWM - I have assigned Mod4+L/R/U/D keys for this - 80% of the time, this is more than enough - this keeps dialogs and temp windows floating by default..
- When I need to tile a window to a corner - or use the 60-40 ratio, I call through to Quicktile - this keyboard config is set to Ctrl-Alt-NUM based on a 5 column grid (not using the NUMPAD keys though since the laptop keyboard doesnt have one)
- This quicktile config is also given in the repository

#### To setup the above ####
- Download/extract quicktile (if needed) to the ```.config/.utils``` directory - the quicktile folder should exist here, you only need the quicktile binary (you might need to install )
- Run ```~/.config/.utils/quicktile/quicktile.sh --help``` to verify (install any dependent packages if needed)
- Enable quicktile to run in daemon mode at start by copying ```quicktile.desktop``` from ```.config/autostart-disabled``` to ```.config/autostart```

Now while the current setup follows the above approach, I'm sure that my workflow/workspaces config should be achievable with other tiling WMs.. I will be trying this out (i3+Polybar/XMonad+Xmobar, etc) - will update the repo once done.

### Things to do (pending): ###
- Discord/Lightcord setup for 
- Awesome WM vs Xmonad vs I3+Polybar [remove/replace Conky/EWW/XFCE with a tiling WM+bar+dunst]

One last note: No guarantees, no assurances.. If you are using this repo, you are expected to know what you are doing - so use as you see fit, **you** are in control, I'm not responsible for what happens.. :)

