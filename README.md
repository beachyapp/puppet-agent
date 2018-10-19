# Puppet

This repository contains Puppet files to be placed in `/etc/puppet`.

## Initial Deployment

Install Puppet from apt:

```
apt-get update
apt-get install -y wget lsb-release

wget -O /tmp/puppet5.deb http://apt.puppetlabs.com/puppet5-release-`lsb_release -cs`.deb
dpkg -i /tmp/puppet5.deb

apt-get update
apt-get -y install git-core puppet-agent
```

Move the default /etc/puppetlabs into /etc/puppetlabs-bak in case you fuck up:

```
mv /etc/puppetlabs/ /etc/puppetlabs-bak
```

Clone this repository into /etc/puppetlabs:

```
git clone https://github.com/beachyapp/puppet.git /etc/puppetlabs
```

Puppet doesn't come with it's own stdlib, so we need to install it:

```
/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib --version 5.1.0
```

Finally, apply the configuration to the server:

```
/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/manifests/site.pp
```

The configuration will setup a cronjob to git pull every 30 minutes. After each
git pull, the new configuration will run automatically.

## Deploying Changes

Push changes to this repository. All servers that followed the steps under
"Initial Deployment" will receive the changes within 30 minutes.

## Testing

You can test your changes using this repository's Dockerfile:

```
docker build -t puppet .
docker run -ti -v $(pwd):/etc/puppetlabs -v $HOME/.aws/:/root/.aws puppet /bin/bash
```

Changes you make to the code will automatically sync with /etc/puppetlabs inside
of the container. You can run `puppet apply` using the same command at the bottom
of "Initial Deployment".