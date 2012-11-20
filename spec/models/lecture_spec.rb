require 'spec_helper'

describe Lecture do
  # ID do Lecture no Redu
  it { should respond_to(:core_id) }
  it { should_not validate_presence_of(:core_id) }
  it { should_not validate_uniqueness_of(:core_id) }

  # Nome do Lecture
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Modulo ao qual o Lecture pertence
  it { should belong_to(:subject) }
  it { should validate_presence_of(:subject) }

  # Aplicativo ao qual a aula está vinculada
  it { should belong_to(:app) }
end
