# Create myVM
class profile::example::vms::myvm1()
{
  ovm_virtual_disk { 'default/repo01/vm01_disk':
    ensure    => 'present',
    disk_type => 'VIRTUAL_DISK',
    size      => '2G',
  }

  ->ovm_vm { 'default/repo01/server_pool_1/ovs01.example.com/myvm1':
    ensure                  => 'present',
    boot_order              => ['DISK', 'CDROM'],
    cpu_count               => 2,
    cpu_count_limit         => 2,
    cpu_priority            => 50,
    cpu_utilization_cap     => 100,
    description             => 'Test 1',
    keymap_name             => 'en-us',
    memory                  => 192,
    memory_limit            => 192,
    os_type                 => 'Oracle Linux 7',
    restart_action_on_crash => 'RESTART',
    vm_domain_type          => 'XEN_HVM',
    vm_mouse_type           => 'OS_DEFAULT',
    vm_run_state            => 'RUNNING',
    vm_start_policy         => 'BEST_SERVER',
    virtual_disks           => ['0:repo01/vm01_disk']
  }
}
