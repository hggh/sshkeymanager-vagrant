# == Class: sshkeymanager::setup

class sshkeymanager::setup {
  file { $sshkeymanager::directory:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    force   => true,
    purge   => true,
    recurse => true,
  }
}
