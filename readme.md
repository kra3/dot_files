There are 3 other projects in use as of now, (2 to show cpu & mem load and one for dir management)
- screen-cpu-mem-load
- tmux-cpu-mem-load
- z 

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


NB: I don't use zsh, it's just a curiosity
