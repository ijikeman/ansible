require 'spec_helper'

describe package('crontabs') do
  it { should be_installed }
end

describe service('crond') do
  it { should be_enabled }
  it { should be_running }
end
