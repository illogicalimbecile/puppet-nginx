require 'spec_helper'

describe 'nginx_passenger::install' do
  let(:title) { 'nginx_passenger_install' }

  context 'with default parameters' do
    it {
      should contain_file('/usr/local/src').with({
        'ensure' => 'directory',
        'owner'  => 'root',
        'group'  => 'wheel',
        'mode'   => '0755',
      })
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
  end
end
