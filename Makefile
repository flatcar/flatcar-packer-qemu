PACKER_CMD ?= packer
RELEASE ?= alpha
DIGEST_URL ?= https://$(RELEASE).release.flatcar-linux.net/amd64-usr/current/flatcar_production_iso_image.iso.DIGESTS
CONFIG ?= flatcar-linux-config.yml
DISK_SIZE ?= 40000
MEMORY ?= 2048M
BOOT_WAIT ?= 45s

flatcar-linux: builds/flatcar-linux-$(RELEASE).qcow2

builds/flatcar-linux-$(RELEASE).qcow2:
	$(eval ISO_CHECKSUM := $(shell curl -s "$(DIGEST_URL)" | grep "flatcar_production_iso_image.iso" | awk '{ print length, $$1 | "sort -rg"}' | awk 'NR == 1 { print $$2 }'))

	ct -pretty -in-file $(CONFIG) -out-file ignition.json

	$(PACKER_CMD) build -force \
		-var 'release=$(RELEASE)' \
		-var 'iso_checksum=$(ISO_CHECKSUM)' \
		-var 'iso_checksum_type=sha512' \
		-var 'disk_size=$(DISK_SIZE)' \
		-var 'memory=$(MEMORY)' \
		-var 'boot_wait=$(BOOT_WAIT)' \
		flatcar-linux.json

clean:
	rm -rf builds

cache-clean:
	rm -rf packer_cache

ct: /usr/local/bin/ct

/usr/local/bin/ct:
	wget -O /usr/local/bin/ct https://github.com$(shell curl -s -L https://github.com/flatcar/flatcar-linux-config-transpiler/releases/latest | grep -m 1 -o "/flatcar/flatcar-linux-config-transpiler/releases/download/.*unknown-linux-gnu")
	chmod +x /usr/local/bin/ct

ct-update: ct-clean ct

ct-clean:
	rm /usr/local/bin/ct

.PHONY: clean cache-clean ct-update ct-clean
