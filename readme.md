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
cd ~/.tmux-tony/vendor/tmux-mem-cpu-load
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

