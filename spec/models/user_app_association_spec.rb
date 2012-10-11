require 'spec_helper'

describe UserAppAssociation do
  it { should belong_to(:user) }
  it { should belong_to(:app) }
end
