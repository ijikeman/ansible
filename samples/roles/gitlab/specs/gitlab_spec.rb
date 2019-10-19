require 'spec_helper'

# Check Package
describe package('gitlab-ce') do
  it { should_not be_installed }
end
