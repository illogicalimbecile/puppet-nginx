require 'spec_helper'

describe 'nginx_passenger::install' do
  let(:title) { 'nginx_passenger::install' }

  context 'with default parameters' do
    let(:params) {{ }}

    it { should contain_file('/usr/local/src') \
      .with_ensure('directory') \
      .with_owner('root') \
      .with_group('wheel') \
      .with_mode('0755')
    }

    it { should contain_exec('nginx-download') \
      .with_command('fetch http://nginx.org/download/nginx-1.6.0.tar.gz') \
      .with_cwd('/usr/local/src') \
      .with_unless('test -f /usr/local/src/nginx-1.6.0.tar.gz')
    }

    it { should contain_exec('nginx-extract') \
      .with_command('tar zxf nginx-1.6.0.tar.gz') \
      .with_cwd('/usr/local/src') \
      .with_unless('test -d /usr/local/src/nginx-1.6.0')
    }

    it { should contain_exec('passenger-download') \
      .with_command('fetch http://s3.amazonaws.com/phusion-passenger/releases/passenger-4.0.45.tar.gz') \
      .with_cwd('/usr/local/src') \
      .with_unless('test -f /usr/local/src/passenger-4.0.45.tar.gz')
    }

    it { should contain_exec('passenger-extract') \
      .with_command('tar zxf passenger-4.0.45.tar.gz') \
      .with_cwd('/usr/local/src') \
      .with_unless('test -d /usr/local/src/passenger-4.0.45')
    }

    it { should contain_exec('passenger-install') \
      .with_command('./bin/passenger-install-nginx-module --auto --prefix=/usr/local/nginx --nginx-source-dir=/usr/local/src/nginx-1.6.0 --languages=nodejs --extra-configure-flags="--user=www --group=www"') \
      .with_cwd('/usr/local/src/passenger-4.0.45')
    }

    it { should contain_file('nginx-conf') \
      .with_ensure('link') \
      .with_path('/usr/local/etc/nginx') \
      .with_target('/usr/local/nginx/conf')
    }

    it { should contain_file('nginx-bin') \
      .with_ensure('link') \
      .with_path('/usr/local/sbin/nginx') \
      .with_target('/usr/local/nginx/sbin/nginx')
    }

    it { should contain_file('nginx-pid') \
      .with_ensure('link') \
      .with_path('/var/run/nginx.pid') \
      .with_target('/usr/local/nginx/logs/nginx.pid')
    }

    it { should contain_file('nginx-logs') \
      .with_ensure('link') \
      .with_path('/var/log/nginx') \
      .with_target('/usr/local/nginx/logs')
    }

    it { should contain_file('nginx-init') \
      .with_ensure('file') \
      .with_path('/usr/local/etc/rc.d/nginx') \
      .with_owner('root') \
      .with_group('wheel') \
      .with_mode('0555')
    }
  end

  context 'with a given build_dir' do
    let(:params) {{ :build_dir => '/opt/src' }}

    it { should contain_file('/opt/src') \
      .with_ensure('directory') \
      .with_owner('root') \
      .with_group('wheel') \
      .with_mode('0755')
    }

    it { should contain_exec('nginx-download') \
      .with_command('fetch http://nginx.org/download/nginx-1.6.0.tar.gz') \
      .with_cwd('/opt/src') \
      .with_unless('test -f /opt/src/nginx-1.6.0.tar.gz')
    }

    it { should contain_exec('nginx-extract') \
      .with_command('tar zxf nginx-1.6.0.tar.gz') \
      .with_cwd('/opt/src') \
      .with_unless("test -d /opt/src/nginx-1.6.0")
    }

    it { should contain_exec('passenger-download') \
      .with_command('fetch http://s3.amazonaws.com/phusion-passenger/releases/passenger-4.0.45.tar.gz') \
      .with_cwd('/opt/src') \
      .with_unless('test -f /opt/src/passenger-4.0.45.tar.gz')
    }

    it { should contain_exec('passenger-extract') \
      .with_command('tar zxf passenger-4.0.45.tar.gz') \
      .with_cwd('/opt/src') \
      .with_unless('test -d /opt/src/passenger-4.0.45')
    }

    it { should contain_exec('passenger-install') \
      .with_command('./bin/passenger-install-nginx-module --auto --prefix=/usr/local/nginx --nginx-source-dir=/opt/src/nginx-1.6.0 --languages=nodejs --extra-configure-flags="--user=www --group=www"') \
      .with_cwd('/opt/src/passenger-4.0.45')
    }
  end
end
