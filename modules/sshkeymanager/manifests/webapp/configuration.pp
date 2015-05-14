# == Class: sshkeymanager::webapp::configuration

class sshkeymanager::webapp::configuration {
  $django_secret_key = $sshkeymanager::webapp::django_secret_key
  $puppetdb          = $sshkeymanager::webapp::puppetdb
  $database_driver   = $sshkeymanager::webapp::database_driver
  $api_keys          = $sshkeymanager::webapp::api_keys
  $allowed_hosts     = $sshkeymanager::webapp::allowed_hosts

  $config = "${sshkeymanager::webapp::install_dir}/sshkeymanager/keymanager/settings.py"
  file { $config:
    ensure  => present,
    owner   => $sshkeymanager::webapp::user,
    group   => $sshkeymanager::webapp::group,
    mode    => '0640',
    content => template('sshkeymanager/settings.py.erb'),
    notify  => Exec['manage_migrate'],
  }

  $application_path = "${sshkeymanager::webapp::install_dir}/sshkeymanager"
  file { $sshkeymanager::webapp::wgsi_path:
    ensure  => present,
    owner   => $sshkeymanager::webapp::user,
    group   => $sshkeymanager::webapp::group,
    mode    => '0644',
    content => template('sshkeymanager/skm-django.wsgi.erb'),
  }

  $migrate_command = "${application_path}/manage.py migrate"
  exec { 'manage_migrate':
    refreshonly => true,
    user        => $sshkeymanager::webapp::user,
    cwd         => $application_path,
    command     => $migrate_command,
  }
}
