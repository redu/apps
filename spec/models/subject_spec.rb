require 'spec_helper'

describe Subject do
  # ID do Subject no Redu
  it { should respond_to(:core_id) }
  it { should_not validate_presence_of(:core_id) }
  it { should_not validate_uniqueness_of(:core_id) }

  # Nome do Subject
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Disciplina à qual o Subject pertence
  it { should belong_to(:space) }
  it { should validate_presence_of(:space) }

  #Lectures do subject
  it { should have_many(:lectures)}
end
