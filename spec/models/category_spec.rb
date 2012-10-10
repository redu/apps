require 'spec_helper'

describe Category do
   it { should have_many(:app_category_associations)}
   it { should have_many(:apps).through(:app_category_associations)}
end
