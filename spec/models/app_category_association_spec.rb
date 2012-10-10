require 'spec_helper'

describe AppCategoryAssociation do
   it {should belong_to(:app)}
   it {should belong_to(:category)}
end
