class cron_puppet {
  package { 'cron':
    ensure => installed,
  }

  # Ensure old post-merge hook is not there
  file { 'post-hook':
    ensure  => absent,
    path    => '/etc/puppetlabs/.git/hooks/post-merge',
  }

  # Puppet apply every 20mins
  cron { 'puppet-apply':
    ensure  => present,
    command => "/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/manifests/site.pp",
    user    => root,
    minute  => '*/20',
    require => [ Package['cron'] ],
  }


  # Git pull puppet every 30mins
  cron { 'git-pull':
    ensure  => present,
    command => "cd /etc/puppetlabs; /usr/bin/git pull",
    user    => root,
    minute  => '*/30',
    require => [ Package['cron'] ],
  }
}
