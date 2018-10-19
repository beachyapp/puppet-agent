class aws_ssm_environment {
  package { 'aws-sdk-ssm':
    ensure   => 'installed',
    provider => 'puppet_gem',
  }

  $facts['env'].each |String $key, String $value| {
    file_line { "$${key}":
      path => '/etc/environment',
      line => "export ${key}=${value}",
    }
  }
}
