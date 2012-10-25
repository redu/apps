require 'spec_helper'

describe Category do
  it { should respond_to(:name) }
  it { should respond_to(:kind) }
  it { should have_many(:app_category_associations)}
  it { should have_many(:apps).through(:app_category_associations)}
end
