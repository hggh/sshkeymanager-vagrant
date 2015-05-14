# == Class: sshkeymanager
#
# publish your SSH Public Key configuration from SSH Key Manager to your hosts
#
# === Parameters
#
# [*directory*]
#   store the ssh public keys inside. default: /etc/sshkeymanager
#
# === Examples
#
#  class { 'sshkeymanager':
#  }
#
#  class { 'sshkeymanager':
#    directory => '/etc/sshkeymanager'
#  }
#
# === Authors
#
# Jonas Genannt <jonas@brachium-system.net>
#
# === Copyright
#
# Copyright 2015 Jonas Genannt
#
class sshkeymanager(
  $directory = $sshkeymanager::params::directory,
) inherits sshkeymanager::params {

  include sshkeymanager::setup

  create_resources(sshkeymanager::key, hiera('sshkeymanager', {}))
}
