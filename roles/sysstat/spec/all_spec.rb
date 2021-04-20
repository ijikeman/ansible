require 'spec_helper'

# Check Running
describe service('sysstat') do
  it { should be_enabled }
  it { should be_running }
end
