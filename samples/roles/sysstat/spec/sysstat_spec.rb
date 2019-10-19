require 'spec_helper'

# Check Package
describe package('sysstat') do
  it { should be_installed }
end

# Check Daemon
describe service('sysstat') do
  it { should be_enabled }
  it { should be_running }
end
