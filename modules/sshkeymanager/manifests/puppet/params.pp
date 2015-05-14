# == Class: sshkeymanager::puppet::params

class sshkeymanager::puppet::params {
  $directory = '/etc/sshkeymanager-hiera'
  $storepath = '/etc/sshkeymanager-hiera/{environment}/nodes/{fqdn}.json'
  $address   = 'http://localhost:8000/api/getkeys/'
  $user      = 'skm-puppet'
  $group     = 'skm-puppet'
  $manage_user = true
  $cron_ensure = present
  $cron_minute = '*/10'
  $cron_hour   = '7-19'
  $cron_month = '*'
  $cron_monthday = '*'
  $cron_weekday = '1-5'
}
