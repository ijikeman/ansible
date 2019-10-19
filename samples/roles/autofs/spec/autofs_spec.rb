require 'spec_helper'

# Check Package
%w{autofs}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# Check Running
describe service('autofs') do
  it { should be_enabled }
  it { should be_running }
end
