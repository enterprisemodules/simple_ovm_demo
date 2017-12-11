# ovm_demo - Demo for installation and management of Oracle VM infrastructure

This module is used with conjunction of Oracle VM Manager to manage Oracle VM infrastructure.

## Required Software

- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)
- Oracle VM ISOs (`V952527-01.iso`, `V952528-01.iso`, `V952529-01.iso`)

## Setup

- Put Oracle VM installation ISOs `V952527-01.iso`, `V952528-01.iso`, `V952529-01.iso` into `/software` directory
- Run `$ vagrant up`

## Usage

SSH into ovm_host

    $ vagrant ssh ovm_host

Login as root

    $ sudo su

Check ovm_manager

    $ puppet resource ovm_manager

    Notice: Running on VM. You are free to use  on a WorkStation VM. Check the license requirements on http://www.enterprisemodules.com/ for details.
    ovm_manager { 'default':
      ensure      => 'present',
      manager_url => 'https://ovmm.example.com',
      password    => '<encrypted value>',
      port        => 7002,
      username    => 'admin',
      verify_ssl  => 'false',
    }

Manage
### SSH

SSH to OVM Manager

    $ vagrant ssh ovm_host

SSH to NFS Server

    $ vagrant ssh nfs_server_1

## Open Source

This software is provided under the [Enterprise Modules Open Source license](../master/LICENSE.pdf). This means you are free to add your own features. We only support accepted pull requests, so if you want your own feature to be added and think it is useful for other customers, please submit a Pull Request.

This software is build with or on other open source components. Check [here](../master/documentation/components.md) for a list of all used components and their license
