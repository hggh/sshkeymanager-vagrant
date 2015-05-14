

class { 'apache':
  default_mods        => false,
  default_confd_files => false,
  default_vhost       => false,
}
class { 'apache::mod::wsgi':
  package_name => 'libapache2-mod-wsgi-py3',
  mod_path     => '/usr/lib/apache2/modules/mod_wsgi.so',
}

package { 'git':
  ensure => present,
}->
class { 'sshkeymanager::webapp':
  django_secret_key => '23fdDfsd§sf#fdff§$3Ddd',
  api_keys          => [ 'foobar', 'examplekey' ],
}->
apache::vhost { 'sshkeymanager-django':
  port                        => 80,
  docroot                     => '/home/skm-django/http-docroot',
  aliases                     => [
                                    {
                                      alias => '/static',
                                      path  => '/home/skm-django/skm-django/sshkeymanager/keymgmt/static/',
                                    }
                                ],
  wsgi_daemon_process         => 'skm-django',
  wsgi_daemon_process_options => {
                                      processes    => '2',
                                      threads      => '15',
                                      user         => 'skm-django',
                                      group        => 'skm-django',
                                      display-name => '%{GROUP}',
                                },
  wsgi_import_script          => '/home/skm-django/skm-django.wsgi',
  wsgi_import_script_options  => {
                                    process-group     => 'skm-django',
                                    application-group => '%{GLOBAL}'
                                },
  wsgi_process_group          => 'skm-django',
  wsgi_script_aliases         => {
                                    '/' => '/home/skm-django/skm-django.wsgi'
                                },
}
