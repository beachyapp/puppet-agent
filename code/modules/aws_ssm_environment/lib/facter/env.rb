Facter.add('env') do
  setcode do
    begin
      require 'aws-sdk-ssm'
      region = system('which ec2metadata') && `ec2metadata --availability-zone`[/us-(.*)-\d/]
      environment = ENV['APP_ENV']

      if region && environment
        ssm = Aws::SSM::Client.new(region: region)
        result = ssm.get_parameters_by_path path: "/#{environment}/env"

        vars = result.parameters.map do |param|
          next unless param.name.include? '/'
          [ param.name.split('/').last, param.value ]
        end

        Hash[vars.compact]
      else
        {}
      end
    rescue LoadError => e
      Puppet.warning <<~ERROR
        aws-sdk-ssm isn't installed yet. It will be installed by Puppet and this
        fact will load on the next run.
      ERROR

      {}
    end
  end
end