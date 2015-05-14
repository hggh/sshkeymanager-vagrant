# == Class: sshkeymanager::webapp::user

class sshkeymanager::webapp::user (
  $user,
  $home,
  $group,
) {

  group { $group:
    ensure => present,
  }

  user { $user:
    ensure  => present,
    shell   => '/bin/bash',
    comment => 'sshkeymanager django app',
    home    => $home,
    gid     => $group,
    require => Group[$group],
  }

  file { $home:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

}
