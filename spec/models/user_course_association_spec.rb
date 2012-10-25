require 'spec_helper'

describe UserCourseAssociation do
  it { should belong_to(:user) }
  it { should belong_to(:course) }
end
