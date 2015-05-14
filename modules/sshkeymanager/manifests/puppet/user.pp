# == Class: sshkeymanager::puppet::user

class sshkeymanager::puppet::user(
  $user,
  $group
) {

  group { $group:
    ensure => present,
  }

  user { $user:
    ensure  => present,
    shell   => '/bin/sh',
    comment => 'SSH Key Manager Puppet Export',
    gid     => $group,
    home    => '/',
  }
}
