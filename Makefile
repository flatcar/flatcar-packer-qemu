PACKER_CMD ?= packer
RELEASE ?= alpha
VERSION ?= 1702.1.0
DIGEST_URL ?= https://$(RELEASE).release.flatcar-linux.net/amd64-usr/current/flatcar_production_iso_image.iso.DIGESTS
CONFIG ?= flatcar-linux-config.yml
DISK_SIZE ?= 40000
MEMORY ?= 2048M
BOOT_WAIT ?= 45s
CT_DOWNLOAD_URL ?= https://github.com/coreos/container-linux-config-transpiler/releases/download
CT_VER ?= v0.7.0
ARCH ?= $(shell uname -m)
HEADLESS ?= false

flatcar-linux: builds/flatcar-linux-$(RELEASE).qcow2

builds/flatcar-linux-$(RELEASE).qcow2:
	$(eval ISO_CHECKSUM := $(shell curl -s "$(DIGEST_URL)" | grep "flatcar_production_iso_image.iso" | awk '{ print length, $$1 | "sort -rg"}' | awk 'NR == 1 { print $$2 }'))

	ct -pretty -in-file $(CONFIG) -out-file ignition.json

	$(PACKER_CMD) build -force \
		-var 'flatcar_channel=$(RELEASE)' \
		-var 'flatcar_version=$(VERSION)' \
		-var 'iso_checksum=$(ISO_CHECKSUM)' \
		-var 'iso_checksum_type=sha512' \
		-var 'disk_size=$(DISK_SIZE)' \
		-var 'memory=$(MEMORY)' \
		-var 'boot_wait=$(BOOT_WAIT)' \
		-var 'headless=$(HEADLESS)' \
		flatcar-linux.json

clean:
	rm -rf builds

cache-clean:
	rm -rf packer_cache

ct: /usr/local/bin/ct

/usr/local/bin/ct:
	wget $(CT_DOWNLOAD_URL)/$(CT_VER)/ct-$(CT_VER)-$(ARCH)-unknown-linux-gnu -O /usr/local/bin/ct
	chmod +x /usr/local/bin/ct

ct-update: ct-clean ct

ct-clean:
	rm /usr/local/bin/ct

.PHONY: clean cache-clean ct-clean
