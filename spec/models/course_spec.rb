require 'spec_helper'

describe Course do
  # ID do Course no Redu
  it { should respond_to(:core_id) }
  it { should validate_presence_of(:core_id) }
  it { should validate_uniqueness_of(:core_id) }

  # Nome do Course
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Usuário que criou o Course
  it { should respond_to(:owner) }
  it { should validate_presence_of(:owner) }
  it { should belong_to(:owner) }

  # Usuários que participam do Course
  it { should have_many(:user_course_associations), :dependent => :destroy }
  it { should have_many(:users).through(:user_course_associations) }

  # Ambiente ao qual o Course pertence
  it { should belong_to(:environment) }
  it { should validate_presence_of(:environment) }

  #Espaços do curso
  it { should have_many(:spaces)}
end
