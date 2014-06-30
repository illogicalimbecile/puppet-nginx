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

    it {
      should contain_exec('nginx-download').with({
        'command' => 'fetch http://nginx.org/download/nginx-1.6.0.tar.gz',
        'cwd' => '/usr/local/src',
      })
    }
  end
end
