# == Class: sshkeymanager::puppet

class sshkeymanager::puppet(
  $apikey,
  $directory = $sshkeymanager::puppet::params::directory,
  $storepath = $sshkeymanager::puppet::params::storepath,
  $address   = $sshkeymanager::puppet::params::address,
  $user      = $sshkeymanager::puppet::params::user,
  $group     = $sshkeymanager::puppet::params::group,
  $manage_user = $sshkeymanager::puppet::params::manage_user,
  $cron_ensure = $sshkeymanager::puppet::params::cron_ensure,
  $cron_minute = $sshkeymanager::puppet::params::cron_minute,
  $cron_hour = $sshkeymanager::puppet::params::cron_hour,
  $cron_month = $sshkeymanager::puppet::params::cron_month,
  $cron_monthday = $sshkeymanager::puppet::params::cron_monthday,
  $cron_weekday = $sshkeymanager::puppet::params::cron_weekday
) inherits sshkeymanager::puppet::params {

  validate_bool($manage_user)

  cron { 'run-sshkeymanager-update-exporter':
    ensure   => $cron_ensure,
    user     => $user,
    command  => '/usr/bin/sshkeymanager-puppet',
    minute   => $cron_minute,
    hour     => $cron_hour,
    month    => $cron_month,
    monthday => $cron_monthday,
    weekday  =>  $cron_weekday,
  }

  if ($manage_user) {
    class { 'sshkeymanager::puppet::user':
      user  => $user,
      group => $group,
    }
  }

  file { $directory:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { '/usr/bin/sshkeymanager-puppet':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/sshkeymanager/sshkeymanager',
  }

  file { '/etc/sshkeymanager.yaml':
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => template('sshkeymanager/sshkeymanager.yaml.erb'),
  }
}
