# My dotfiles!

Welcome! If you are reading this, then you came up to my personal dotfiles repository. Here I store all the stupid stuff that I try to do to my systems.
If you need help or anything, feel free to open an issue about it. Keep in mind that my configurations are designed to solve my problems with my specific hardware.
I can try to help you the best I can, but that's all.

PD: This docs are a guide for future me. I know this code but I also know me. I am sure I am gonna read this constantly. Thanks past me!

## Prerequisites (TODO)
It is essential to have NixOs installed. That's it. The rest is on me.

## Installing (TODO)

## My personal computers (TODO)

### Spaceship
Spaceship is what I call my big monstruos desktop pc because it is basically a rocket. A small and humble rocket.

### Framework
Framework is actually my recently bought Framework 13 notebook. It runs a AMD Ryzen 5 7640U. So, yeah, no Intel and thank god no NVIDIA.

## Connecting to Bluetooth
So, bluetooth is simple. Bluez comes with a handy cli app called bluetoothctl that simplify most of stuff.

#### Outbound connection (pairing from my PC to another device)
I have a beautiful yellow Logitech POP Keys. This keyboard can be connected through a USB dongle or via bluetooth.
To connect it using bluetooth you need to do this:

Start bluetoothctl and turn the agent on. Running bluetoothctl with no arguments starts an interactive shell.

```console
foo@bar:~$ bluetoothctl
```

Once inside, run this.

```console
# Turn the agent on.
# The agent is the cool dude that checks if two devices can be paired by sending and checking a code or by simply asking the second device to accept the pairing
[bluetooth]# agent on
Agent registered
# Set the default agent for some reason. Idk really
[bluetooth]# default-agent
Default agent request successful
```

After that, you can start scanning for your device. In my case, my slick bluetooth keyboard

```console
# Scan the nearby devices
[bluetooth]# scan on
# This will start the scanning phase. Soon your screen will be filled with text
Discovery started
[CHG] Controller 00:1A:7D:DA:71:08 Discovering: yes
# Which is followed with some logs that look like this
[NEW] Device 08:3E:8E:E6:79:47 annapurna
[NEW] Device 00:25:56:D1:36:6B ubuntu-0 ....
[NEW] Device <bluetooth address> <name>
```

Once you find your device, copy its MAC address.

```console
# Scan the nearby devices
[bluetooth]# scan on
# This will start the scanning phase. Soon your screen will be filled with text
Discovery started
[CHG] Controller 00:1A:7D:DA:71:08 Discovering: yes
# Which is followed with some logs that look like this
[NEW] Device 08:3E:8E:E6:79:47 annapurna
[NEW] Device 00:25:56:D1:36:6B ubuntu-0 ....
[NEW] Device <bluetooth address> <name>
```

Now, you just need to pair them together
```console
[bluetooth]# pair <bluetooth MAC address>
Attempting to pair with <bluetooth MAC address>
[CHG] Device <bluetooth MAC address> Connected: yes
Request confirmation
[agent] Confirm passkey 687331 (yes/no): yes
```

Finally, you can stop scanning and exit.

```console
# You can stop scanning now
[bluetooth]# scan off
[bluetooth]# exit
```

That's it. Bluetooth done. It would be nice to have this in a GUI but that's for future me.
For some reason, Hyprland (at least by now) is not able to connect to new devices and use them. I tried with USB keyboards and mouses. I need to restart Hyprland. I guess it's a bug from version 0.42.
Anyway, if bluetooth doesn't work, try restarting Hyprland.

## Launching Hyprland (TODO)
I don't start Hyprland when booting up because I don't always need a desktop to get through the day. That said, to start Hyprland simply run:

```console
foo@bar:~$ Hyprland
```

That's it. Enjoy!

## Setting up Wifi (TODO)
I am a very VERY lazy dude, so I didn't actually write any scripts to handle the network connection.
If you are using a Ethernet cable then just plug that shit in. If you are using the good old wifi, I recommend using the nmtui command to connect to your network.
Other than that, feel free to do whatever the hell you want. You are the protagonist of your own life.

## Development tools (TODO)

## Nixvim (TODO)
So, Nixvim is Neovim, but all of the config is done using Nix instead of Lua. I find nixvim pretty cool and I don't have to actually config anything, so that's a plus.
To run nixvim, just run neovim as always

```console
foo@bar:~$ nvim
```

Running vim also works ;) it's just an alias under the hood, so yeah

```console
foo@bar:~$ vim
```

## NVIDIA/AMD (TODO)
Jesus christ do I have to write shit here aswell? ffs


