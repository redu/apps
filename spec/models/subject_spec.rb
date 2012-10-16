require 'spec_helper'

describe Subject do
  # ID do Subject no Redu
  it { should respond_to(:suid) }
  it { should validate_presence_of(:suid) }
  it { should validate_uniqueness_of(:suid) }

  # Nome do Subject
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Disciplina à qual o Subject pertence
  it { should belong_to(:space) }
  it { should validate_presence_of(:space) }

  #Lectures do subject
  it { should have_many(:lectures)}
end
