FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y wget lsb-release

# Add puppet package
RUN wget -O /tmp/puppet5.deb https://apt.puppetlabs.com/puppet5-release-`lsb_release -cs`.deb
RUN dpkg -i /tmp/puppet5.deb

# Install puppet
RUN apt-get update
RUN apt-get install -y puppet-agent git-core

VOLUME /etc/puppetlabs
VOLUME /root/.aws