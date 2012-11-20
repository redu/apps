require 'spec_helper'

describe Space do
  # ID do Space no Redu
  it { should respond_to(:core_id) }
  it { should validate_presence_of(:core_id) }
  it { should validate_uniqueness_of(:core_id) }

  # Nome do Space
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Ambiente ao qual o Space pertence
  it { should belong_to(:course) }
  it { should validate_presence_of(:course) }

  #Subjects do Space
  it { should have_many(:subjects)}
end
