require 'spec_helper'

describe App do
   it {should have_many(:app_category_associations)}
   it {should have_many(:categories).through(:app_category_associations)}
end
