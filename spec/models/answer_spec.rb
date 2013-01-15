require 'spec_helper'

describe Answer do
  it { should be_a_kind_of(Comment) }
  it { should respond_to(:in_response_to) }
  it { should validate_presence_of(:in_response_to) }
end