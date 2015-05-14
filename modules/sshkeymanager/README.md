# sshkeymanager [![Build Status](https://api.travis-ci.org/hggh/sshkeymanager-puppet.svg)](https://travis-ci.org/hggh/sshkeymanager-puppet)

publish your SSH Key Manager configuration to your hosts via Puppet.

you need the SSH Key Manager Django Webapp: https://github.com/hggh/sshkeymanager-django

Vagrant Box available: https://github.com/hggh/sshkeymanager-vagrant

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Parameters](#parameters)
5. [Hiera configuration](#hiera)
6. [SSH configuration](#ssh)

## Overview

Puppet module to publish your SSH Key Manager configuration for your hosts via
Puppet. This module requires to use the SSH Key Manager Application
(Django Webapp) and export the configuration to JSON format for Hiera.

## Requirements

* puppetlabs/stdlib
* Hiera

## Usage

### deployment of ssh public keys

use the main class for deploy your ssh public keys to your hosts.

```
class { 'sshkeymanager':
}
```

### export ssh public key configuration from webapp to the puppet master

on your puppet master server the keys should exported. This class installs the api client programm, the cronjob and the directories:

```
class { 'sshkeymanager::puppet':
  directory => '/etc/sshkeymanager-hiera',
  storepath => '/etc/sshkeymanager-hiera/{environment}/nodes/{fqdn}.json',
  apikey    => 'your-api-key-from-django',
  address   => 'http://localhost:8000/api/getkeys/',
}
```

### install the django webapp with the puppet module

```
class { 'sshkeymanager::webapp':
  django_secret_key => '23fdDfsd§sf#fdff§$3Ddd',
  api_keys          => [ 'foobar', 'examplekey' ],
}
```

## Parameters

```
class { 'sshkeymanager':
  directory => '/etc/sshkeymanager',
}
```

Per default the `sshkeymanager` class uses the directory `/etc/sshkeymanager`.
You can change the directory to your needs.

## Hiera configuration

You need to add the json backend to your Hiera configuration:

```
---
:backends:
   - json
   - yaml
:hierarchy:
  - "nodes/%{clientcert}"
  - "%{environment}"
  - common
:json:
  :datadir: '/etc/sshkeymanager-hiera/%{environment}'
```

## SSH configuration

You need to edit on all servers that uses the `sshkeymanager` class the
SSHd configration to point to the directory there all keys are saved:

```
AuthorizedKeysFile /etc/sshkeymanager/%u 
```

To allow also user key in there own homedirectory you need to setup this:

```
AuthorizedKeysFile /etc/sshkeymanager/%u .ssh/authorized_keys
```

Using the SSH module(https://forge.puppetlabs.com/saz/ssh) from Puppet Forge it looks like:
```
class { 'ssh::server':
  options => {
    'AuthorizedKeysFile' => '/etc/sshkeymanager/%u',
  }
}
```
