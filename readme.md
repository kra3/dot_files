There are 4 other projects in use as of now, (2 to show cpu & mem load and one for dir management & another for a better prompt.)
- screen-cpu-mem-load
- tmux-cpu-mem-load
- z 
- liquidprompt 

To get them:

```bash
git submodule init
git submodule update
```

You have to compile cpu-mem-load plugins ( I may write a script for it to avoid this step. )
You need cmake to generate make files

```bash
cd tmux/addon            # or screen  if you prefer it - cd screen/addon  
cmake .
make
sudo make install
```

For GUI goodness
- Icons: AwOken -  http://gnome-look.org/content/show.php?content=126344
- Gtk-theme - Malys-rought-dark-left - http://malysss.deviantart.com/art/malys-rought-2-0-for-gnome-3-6-337626780

Which in ubuntu can be achived by:

``` bash
sudo apt-get install gtk2-engines-pixbuf    # for GTK2
sudo apt-get install gtk3-engines-unico     # for GTK3
sudo add-apt-repository ppa:noobslab/malys-themes
sudo add-apt-repository ppa:alecive/antigone
sudo apt-get update
sudo apt-get install malys-rought
sudo apt-get install awoken-icon-theme
awoken-icon-theme-customization  # And follow instructions to select one out of many icon variations
# for font used by theme
mkdir ~/.fonts
wget -O bahamas-font.zip http://dl.dropbox.com/u/53319850/NoobsLab.com/bahamas-font.zip
unzip bahamas-font.zip -d ~/.fonts
```


NB: I don't use zsh, it's just a curiosity
