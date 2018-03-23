# flatcar-packer-qemu

A basic Packer template, Makefile and ignition config file to build QEMU images and a Vagrant box for [Flatcar Linux](https://flatcar-linux.org/).

# Installation
Verify that you have [Packer](https://www.packer.io/intro/getting-started/install.html) installed.

```
$ packer -v
```

Verify that you have [ct](https://github.com/coreos/container-linux-config-transpiler) installed, or use the `ct` target to install it to `/usr/local/bin` for you:
```
$ sudo make ct
```

For all options to customize the image properties, see the [Makefile](Makefile) variables.

### Basic example using defaults (alpha release)

```
$ make flatcar-linux
```

### Building the stable release
```
$ make flatcar-linux RELEASE=stable VERSION=1632.3.0
```

### Building in headless mode
```
$ make flatcar-linux HEADLESS=true
```

### Other make targets

Delete builds:

```
$ make clean
```

Delete the packer cache (making packer download the latest iso image on next build):

```
$ make cache-clean
```

### Running the Vagrant box using libvirt as provider

```
$ vagrant up --provider=libvirt
```

## Other works

This repository is based on other works such as https://github.com/dyson/packer-qemu-coreos-container-linux or https://github.com/bfraser/packer-coreos-qemu .

