require 'spec_helper'

describe Space do
  # ID do Space no Redu
  it { should respond_to(:sid) }
  it { should validate_presence_of(:sid) }
  it { should validate_uniqueness_of(:sid) }

  # Nome do Space
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Ambiente ao qual o Space pertence
  it { should belong_to(:course) }
  it { should validate_presence_of(:course) }

  #Subjects do Space
  it { should have_many(:subjects)}
end
