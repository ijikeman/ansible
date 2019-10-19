require 'spec_helper'

# Check Package
%w{zabbix-release zabbix-agent}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# Check Running
describe service('zabbix-agent') do
  it { should be_enabled }
  it { should be_running }
end

# Check Port
describe port(10050) do
  it { should be_listening }
end
