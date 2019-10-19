require 'spec_helper'

# Check Package
describe package('openssh-server') do
  it { should be_installed }
end

# Check Config
describe file('/etc/ssh/sshd_config') do
  its(:content) { should match '^\s*UseDNS no' }
end

# Check Port
describe port(22) do
  it { should be_listening }
end

# Check Running
describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end
