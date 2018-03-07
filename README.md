# flatcar-packer-qemu
Packer QEMU image builder for Flatcar Linux

A basic Packer template, Makefile and cloud config file to get started building QEMU images for [Flatcar Linux](https://flatcar-linux.org/).

# Installation

```
$ git clone https://github.com/flatcar-linux/flatcar-packer-qemu.git .
$ cd flatcar-packer-qemu
$ cp flatcar-linux-config.yml.example flatcar-linux-config.yml
```

### Makefile variables

```make
PACKER_CMD ?= packer
RELEASE ?= alpha
DIGEST_URL ?= https://$(RELEASE).release.core-os.net/amd64-usr/current/coreos_production_iso_image.iso.DIGESTS
CONFIG ?= flatcar-linux-config.yml
DISK_SIZE ?= 40000
MEMORY ?= 2048M
BOOT_WAIT ?= 45s
```

### Basic example using defaults

```
$ make flatcar-linux
```

### Building the alpha release
```
$ make flatcar-linux RELEASE=alpha
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

### Run vagrant with libvirt provider

```
$ vagrant up --provider=libvirt
```

## Other works

This repository is based on other works such as https://github.com/dyson/packer-qemu-coreos-container-linux or https://github.com/bfraser/packer-coreos-qemu .

