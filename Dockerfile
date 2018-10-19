FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y wget

# Add puppet package
RUN wget -P /tmp https://apt.puppetlabs.com/puppet-release-xenial.deb
RUN dpkg -i /tmp/puppet-release-xenial.deb

# Install puppet
RUN apt-get update
RUN apt-get install -y puppet git-core

