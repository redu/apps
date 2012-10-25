require 'spec_helper'

describe Lecture do
  # ID do Lecture no Redu
  it { should respond_to(:lid) }
  it { should_not validate_presence_of(:lid) }
  it { should_not validate_uniqueness_of(:lid) }

  # Nome do Lecture
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Modulo ao qual o Lecture pertence
  it { should belong_to(:subject) }
  it { should validate_presence_of(:subject) }

  # Aplicativo ao qual a aula está vinculada
  it { should belong_to(:app) }
end
