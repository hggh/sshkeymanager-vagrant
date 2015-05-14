# == Define: sshkeymanager::key

define sshkeymanager::key(
  $keys = [],
) {

  file { "${sshkeymanager::directory}/${name}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => join($keys, "\n"),
  }

}
