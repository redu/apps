require 'spec_helper'

describe UserEnvironmentAssociation do
  it { should belong_to(:user) }
  it { should belong_to(:environment) }
end
