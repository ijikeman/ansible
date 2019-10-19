require 'spec_helper'

#Anacron Not Install Test
describe package('cronie-anacron') do
  it { should_not be_installed }
end

#Nonanacron Install Test
describe package('cronie-noanacron') do
  it { should be_installed }
end

#Crond Running Test
describe service('crond') do
  it { should be_enabled }
  it { should be_running }
end
