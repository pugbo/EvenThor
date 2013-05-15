#!/bin/bash

if [ ! -f /vagrant/app/config/parameters.yml ]; then
    cd /vagrant/app/config/ && cp parameters.yml.dist parameters.yml
fi

PUPPET_DIR=/etc/puppet

sed 's/us\.archive/it\.archive/' -i /etc/apt/sources.list
apt-key add /vagrant/vagrant/resources/keyring/ondrej && cp /vagrant/vagrant/resources/etc/apt/sources.list.d/ondrej-php5.list /etc/apt/sources.list.d/
aptitude update

if [ `which git | wc -l` -eq 0 ]; then
    aptitude install git --assume-yes
fi

if [ ! -d "$PUPPET_DIR" ]; then
    mkdir -p "$PUPPET_DIR"
fi

cp /vagrant/vagrant/puppet/Puppetfile $PUPPET_DIR

if [ `gem list | grep librarian | wc -l` -eq 0 ]; then
  gem install librarian-puppet
  cd $PUPPET_DIR && librarian-puppet install --clean
else
  cd $PUPPET_DIR && librarian-puppet update 
fi
