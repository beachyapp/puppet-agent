class cron_puppet {
  package { 'cron':
    ensure => installed,
  }

  # After git pulling, run puppet apply
  file { 'post-hook':
    ensure  => file,
    path    => '/etc/puppetlabs/.git/hooks/post-merge',
    source  => 'puppet:///modules/cron_puppet/post-merge',
    mode    => "0755",
    owner   => root,
    group   => root,
  }

  # Git pull puppet every 30mins
  cron { 'puppet-apply':
    ensure  => present,
    command => "cd /etc/puppetlabs; /usr/bin/git pull",
    user    => root,
    minute  => '*/30',
    require => [ File['post-hook'], Package['cron'] ],
  }
}
