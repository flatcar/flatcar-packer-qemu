# -*- mode: ruby -*-
# vi: set ft=ruby sw=2 ts=2 :

ENV["TERM"] = "xterm-256color"
ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.require_version '>= 1.6.0'

Vagrant.configure('2') do |config|
  # NOTE: ideally the boxes should be hosted with an own username "flatcar".
  config.vm.box = "dongsupark/flatcar-alpha"

  config.ssh.username = 'core'
  config.ssh.insert_key = true
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 2
    libvirt.memory = 2048
    libvirt.driver = 'kvm'
    libvirt.host = ''
    libvirt.connect_via_ssh = false
    libvirt.storage_pool_name = 'default'
  end
end
