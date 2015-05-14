require 'spec_helper'

describe 'sshkeymanager' do

  context 'with defaults for all parameters' do
    it { should contain_class('sshkeymanager') }

    it { should contain_class('sshkeymanager::params') }

    it { should contain_file('/etc/sshkeymanager').with(
       'ensure' => 'directory',
       'owner'  => 'root',
       'group'  => 'root',
       'mode'   => '0755',
       'purge'  => 'true',
    )}
  end

  context 'with different parameters' do
    let (:params) {
       {
       :directory => '/etc/ssh/keys'
       }
    }
    it { should contain_class('sshkeymanager') }
    it { should contain_file('/etc/ssh/keys').with(
       'ensure' => 'directory',
       'owner'  => 'root',
       'group'  => 'root',
       'mode'   => '0755',
       'purge'  => 'true',
    )}
  end
end
