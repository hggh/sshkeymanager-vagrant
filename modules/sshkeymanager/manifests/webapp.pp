# == Class: sshkeymanager::webapp

class sshkeymanager::webapp(
  $django_secret_key,
  $api_keys                = [],
  $puppetdb                = {},
  $skm_version             = sshkeymanager::webapp::params::skm_version,
  $database_driver         = $sshkeymanager::webapp::params::database_driver,
  $install_database_driver = sshkeymanager::webapp::params::install_database_driver,
  $install_python3         = $sshkeymanager::webapp::params::install_python3,
  $install_django          = $sshkeymanager::webapp::params::install_django,
  $install_bootstrap3      = $sshkeymanager::webapp::params::install_bootstrap3,
  $install_model_utils     = $sshkeymanager::webapp::params::install_model_utils,
  $user                    = $sshkeymanager::webapp::params::user,
  $group                   = $sshkeymanager::webapp::params::group,
  $home                    = $sshkeymanager::webapp::params::home,
  $allowed_hosts           = $sshkeymanager::webapp::params::allowed_hosts
) inherits sshkeymanager::webapp::params {
  $install_dir = "${home}/skm-django"
  $wgsi_path   = "${home}/skm-django.wsgi"

  validate_string($database_driver)
  validate_string($django_secret_key)
  validate_bool($install_python3)
  validate_bool($install_django)
  validate_bool($install_bootstrap3)
  validate_bool($install_model_utils)
  validate_array($api_keys)
  validate_array($allowed_hosts)
  validate_hash($puppetdb)

  # install python3 / django / bootstrap3 dependency:
  class { 'sshkeymanager::webapp::python':
    install_database_driver => $install_database_driver,
    database_driver         => $database_driver,
    install_python3         => $install_python3,
    install_django          => $install_django,
    install_bootstrap3      => $install_bootstrap3,
    install_model_utils     => $install_model_utils,
  }->
  class { 'sshkeymanager::webapp::user':
    user  => $user,
    group => $group,
    home  => $home,
  }->
  class { 'sshkeymanager::webapp::install':
  }->
  class { 'sshkeymanager::webapp::configuration':
  }

}
