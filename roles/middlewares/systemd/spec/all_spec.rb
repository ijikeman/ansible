require 'spec_helper'

describe file('/etc/systemd/system.conf') do
  its(:content) { should match /^CtrlAltDelBurstAction=none$/ }
end

describe file('/etc/systemd/journald.conf') do
  its(:content) { should match /^RateLimitIntervalSec=0$/ }
  its(:content) { should match /^RateLimitBurst=0$/ }
end
