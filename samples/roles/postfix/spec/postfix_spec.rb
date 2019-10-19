require 'spec_helper'

# Check Package
describe package('postfix') do
  it { should be_installed }
end

# Check Port
describe port(25) do
  it { should be_listening }
end

# Check Running
describe service('postfix') do
  it { should be_enabled }
  it { should be_running }
end
