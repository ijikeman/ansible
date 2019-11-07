require 'spec_helper'

#SELinux Test
describe selinux do
  it { should be_disabled }
end

#External Network Ping Test
describe host('8.8.8.8')do
  it { should be_reachable }
end

#Name Resolution Test
describe host('yahoo.co.jp')do
  it { should be_resolvable }
end

#eth0 Link Up Test
describe interface('eth0') do
  it { should be_up }
end

#Not Fix Mac Address
describe file('/etc/udev/rules.d/70-persistent-net.rules') do
  it { should_not be_file }
end

# Disable Ipv6
describe file('/etc/sysconfig/network-scripts/ifcfg-eth0') do
  its(:content) { should match '^\s*IPV6INIT\s*=\s*no' }
end

# Disable Ipv6
describe file('/etc/sysconfig/network-scripts/ifcfg-eth1') do
  its(:content) { should match '^\s*IPV6INIT\s*=\s*no' }
end

describe file('/etc/sysctl.conf') do
  its(:content) { should match '^\s*net.ipv6.conf.all.disable_ipv6\s*=\s*1' }
end

describe file('/etc/sysctl.conf') do
  its(:content) { should match '^\s*net.ipv6.conf.default.disable_ipv6\s*=\s*1' }
end

# Disable Ipv6
describe file('/etc/modprobe.d/modprobe.conf') do
  its(:content) { should match '^\s*install ipv6 /sbin/modprobe -n -i ipv6' }
end

# Check Hostname
hostname=host_inventory['hostname']
describe file('/etc/hostname') do
  its(:content) { should match /^#{hostname}/ }
end

# Check Time Zone
describe command('timedatectl status | grep "Time zone"') do
  its(:stdout) { should match "Asia\/Tokyo" }
end

#Ctrl+Alt+Del Disable Check
describe file('/etc/systemd/system.conf') do
  its(:content) { should match '^\s*CtrlAltDelBurstAction\s*=\s*none' }
end
