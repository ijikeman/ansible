require 'spec_helper'

# Check Package
describe package('logrotate') do
  it { should be_installed }
end
