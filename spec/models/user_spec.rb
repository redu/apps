require 'spec_helper'

describe User do
  # UID Identificador do usuário Redu
  it { should respond_to(:uid) }
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:uid) }

  # Login do usuário Redu
  it { should respond_to(:login) }
  it { should validate_presence_of(:login) }
  it { should validate_uniqueness_of(:login) }
  it { should ensure_length_of(:login).is_at_least(5).is_at_most(20)}

  # Nome do usuário Redu
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  # Token de acesso (caso via API)
  it { should respond_to(:token) }

  # Papel de usuário (especialista / membro)
  it { should respond_to(:role) }
  it { should validate_presence_of(:role) }
  it { FactoryGirl.create(:member).role.should == :member }
  it { FactoryGirl.create(:specialist).role.should == :specialist }

  # Aplicativos favoritos do usuário (ou simplesmente aplicativos do usuário)
  it { should have_many(:user_app_associations) }
  it { should have_many(:apps).through(:user_app_associations) }

  # Comentários que usuário cria em aplicativos
  it { should have_many(:comments) }

  # Thumbnail do usuário
  it { should have_attached_file(:thumbnail) }

  # Ambientes de que o usuário participa
  it { should have_many(:user_environment_associations) }
  it { should have_many(:environments).through(:user_environment_associations) }

  # Disciplinas de que o usuário participa
  it { should have_many(:user_course_associations) }
  it { should have_many(:courses).through(:user_course_associations) }
end
