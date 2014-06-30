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
      .with_unless("test -f /usr/local/src/nginx-1.6.0.tar.gz")
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
  end
end
