# == Class: sshkeymanager::webapp::params

class sshkeymanager::webapp::params {
  $database_driver    = 'sqlite'
  $install_database_driver = true
  $install_python3 = true
  $install_django = true
  $install_bootstrap3 = true
  $install_model_utils = true
  $user = 'skm-django'
  $group = 'skm-django'
  $home = '/home/skm-django'
  $skm_version = '0.1'
  $allowed_hosts = [ '*' ]

}
