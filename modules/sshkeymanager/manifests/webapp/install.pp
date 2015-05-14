# == Class: sshkeymanager::webapp::install

class sshkeymanager::webapp::install {
  vcsrepo { 'skm-django':
    ensure   => present,
    provider => 'git',
    source   => 'https://github.com/hggh/sshkeymanager-django.git',
    path     => $sshkeymanager::webapp::install_dir,
    user     => $sshkeymanager::webapp::user,
    group    => $sshkeymanager::webapp::group,
  }
}
