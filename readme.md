Icons: AwOken -  http://gnome-look.org/content/show.php?content=126344
Gtk-theme - Malys-rought-dark-left

Prep ourself to download submodule:

```bash
git submodule init
```

Download submodule:

```bash
git submodule update
```

Change dir to tmux-mem-cpu-load:

```bash
cd tmux/addon
```

General make file:

```bash
cmake .
```

Compile our binary:

```bash
make
```

Install our binary to `/usr/local/bin/tmux-mem-cpu-load`:

```bash
sudo make install
```

Go home:

```bash
cd ~
```

Update config:

```bash
tmux source-file ~/.tmux.conf
```

I don't use zsh, it's just a curiosity
