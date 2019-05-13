require 'spec_helper'
%(mackerel-agent-plugins mackerel-check-plugins).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('mackerel-agent') do
  it { should be_enabled }
  it { should be_running }
end
