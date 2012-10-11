require 'spec_helper'

describe Environment do
  # ID do Environment no Redu
  it { should respond_to(:eid) }
  it { should validate_presence_of(:eid) }
  it { should validate_uniqueness_of(:eid) }

  # Nome do Environment
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Usuário que criou o Environment
  it { should respond_to(:owner) }
  it { should belong_to(:owner) }
  it { should validate_presence_of(:owner) }

  # Usuários do Environment
  it { should have_many(:user_environment_associations) }
  it { should have_many(:users).through(:user_environment_associations) }
  
  # Thumbnail
  it { should have_attached_file(:thumbnail) }

  # Cursos do Ambiente
  it { should have_many(:courses) }
end
