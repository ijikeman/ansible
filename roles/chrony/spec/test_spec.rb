require 'spec_helper'

# Check Package
describe package('chrony') do
  it { should be_installed }
end

# Check Port
describe port(323) do
  it { should be_listening.with('udp') }
end

# Check Running
describe service('chronyd') do
  it { should be_enabled }
  it { should be_running }
end
