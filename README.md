# Vagrant Box for sshkeymanager project

## start vagrant box

  * git clone https://github.com/hggh/sshkeymanager-vagrant.git
  * cd sshkeymanager-vagrant
  * vagrant up

## access sshkeymanager webinterface

 * http://localhost:9001


## access API

    curl -X POST -d 'API_KEY=foobar'  http://localhost:9001/api/getkeys/
