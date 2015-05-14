# == Class: sshkeymanager::webapp::python

class sshkeymanager::webapp::python (
  $database_driver,
  $install_database_driver,
  $install_python3,
  $install_django,
  $install_bootstrap3,
  $install_model_utils
) {

  $database_driver_package_name = $database_driver ? {
    'sqlite'   => '',
    'mysql'    => 'python3-mysql.connector',
    'postgres' => 'python3-psycopg2',
    default    => fail("${database_driver} has no database_driver_package_name")
  }

  if ($install_database_driver and $database_driver_package_name != '') {
    package { $database_driver_package_name:
      ensure => present,
    }
  }

  if ($install_django) {
    package { [ 'python3', 'python3-pip']:
      ensure => present,
    }

    if ($install_django) {
      package { 'Django':
        ensure   => '1.8',
        provider => 'pip3',
        require  => Package['python3-pip'],
      }
    }

    if ($install_bootstrap3) {
      package { 'django-bootstrap3':
        ensure   => '5.4.0',
        provider => 'pip3',
        require  => Package['Django'],
      }
    }

    if ($install_model_utils) {
      package { 'django-model-utils':
        ensure   => '2.2',
        provider => 'pip3',
        require  => Package['Django'],
      }
    }
  }
}
