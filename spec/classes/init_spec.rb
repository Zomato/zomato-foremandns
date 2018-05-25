require 'spec_helper'

describe 'foremandns' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "foremandns class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should contain_class('foremandns::params') }
        it { should contain_class('foremandns::install').that_comes_before('foremandns::config') }
        it { should contain_class('foremandns::config') }
        it { should contain_class('foremandns::service').that_subscribes_to('foremandns::config') }

        it { should contain_service('foremandns').with_ensure('running').with_enable(true) }
        it { should contain_package('foremandns').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'foremandns class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('foremandns') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end

  context 'archive install method' do
    let(:params) {{
      :install_method => 'archive'
    }}

    install_dir    = '/usr/share/foremandns'
    service_config = '/etc/foremandns/foremandns/foremandns.yaml'
    archive_source = 'https://s3.ap-south-1.amazonaws.com/zomato-foremandns/foremandns-linux-amd64-v1.0.0.tgz'

    describe 'extract archive to install_dir' do
      it { should contain_archive('/tmp/foremandns.tar.gz').with_ensure('present') }
      it { should contain_archive('/tmp/foremandns.tar.gz').with_source(archive_source) }
      it { should contain_archive('/tmp/foremandns.tar.gz').with_extract_path(install_dir) }
    end

    describe 'manage install_dir' do
      it { should contain_file(install_dir).with_ensure('directory') }
      it { should contain_file(install_dir).with_group('root').with_owner('root') }
    end

    describe 'configure foremandns' do
      it { should contain_file(service_config).with_ensure('present') }
    end

    describe 'run foremandns as service' do
      it { should contain_service('foremandns').with_ensure('running').with_provider('base') }
      it { should contain_service('foremandns').with_hasrestart(false).with_hasstatus(false) }
    end

    context 'when service already defined' do
      let(:pre_condition) {
        'service{"foremandns":
          ensure     => running,
          hasrestart => true,
          hasstatus  => true,
        }'
      }
      # let(:params) {{ :service_name => 'foremandns'}}
      describe 'do NOT run service' do
        it { should_not contain_service('foremandns').with_hasrestart(false).with_hasstatus(false) }
      end
    end
  end

  context 'invalid parameters' do
    context 'cfg' do
      let(:facts) {{
        :osfamily => 'Debian',
      }}

      describe 'should raise an error when cfg parameter is not a hash' do
        let(:params) {{
          :cfg => [],
        }}

        it { expect { should contain_package('foremandns') }.to raise_error(Puppet::Error, /cfg parameter must be a hash/) }
      end

      describe 'should not raise an error when cfg parameter is a hash' do
        let(:params) {{
          :cfg => {},
        }}

        it { should contain_package('foremandns') }
      end
    end
  end

  context 'configuration file' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    describe 'should not contain any configuration when cfg param is empty' do
      it { should contain_file('/etc/foremandns/foremandns.yaml').with_content("# This file is managed by Puppet, any changes will be overwritten\n\n") }
    end
  end
end