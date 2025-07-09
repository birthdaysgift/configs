## keyd

`keyd` is system wide daemon which remaps keys using kernel level input primitives (evdev, uinput).


### Installation

1. Add `keyd` PPA (optional).

At the time of writing this readme, `keyd` is absent in official ubuntu apt repo.
But you can install it from keyd's PPA, which you can add via following command:

```bash
sudo add-apt-repository ppa:keyd-team/ppa
sudo apt update
```

2. Install via apt:
```bash
sudo apt update
sudo apt install keyd
```

For some reason, at this moment `keyd` binary installed to the system is called `keyd.rvaiya`.
Probably this will be changed in the future once `keyd` will be added to official apt repo,
but for now we should use `keyd.rvaiya` instead of `keyd`.


### Link configuration

0. Go to this configs project root directory

1. Create soft link from current directory to /etc/keyd

```bash
sudo ln -s ./keyd /etc/keyd
```

2. Start `keyd` daemon service
```bash
sudo systemctl enable --now keyd
```

3. Set key repeat and key delay
```bash
xset r rate 200 40
```

### Notes

- If you changed `keyd` config you have to restart `keyd` daemon:

```bash
sudo keyd.rvaiya reload
```

- You can see `keyd` logs:

```bash
sudo journalctl -eu keyd.rvaiya
```

- You can check key names via `keyd` monitor feature:

```bash
sudo keyd.rvaiya monitor
```

- If you cannot interact with the system due to broken keyd configuration
you can use `backspace+escape+enter` keystroke to turn off `keyd` daemon.

