require 'spec_helper'

describe User do
  # Identificador do usuário Redu
  it { should respond_to(:core_id) }
  it { should validate_presence_of(:core_id) }
  it { should validate_uniqueness_of(:core_id) }

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
  it { should have_many(:user_app_associations).dependent(:destroy) }
  it { should have_many(:apps).through(:user_app_associations) }

  # Comentários que usuário cria em aplicativos
  it { should have_many(:comments).dependent(:destroy) }

  # Thumbnail do usuário
  it { should have_attached_file(:thumbnail) }

  # Ambientes de que o usuário participa
  it { should have_many(:user_environment_associations).dependent(:destroy) }
  it { should have_many(:environments).through(:user_environment_associations) }

  # Disciplinas de que o usuário participa
  it { should have_many(:user_course_associations).dependent(:destroy) }
  it { should have_many(:courses).through(:user_course_associations) }

  # Campos necessários à autenticação
  it { should respond_to(:email) }
  it { should respond_to(:crypted_password) }
  it { should respond_to(:password_salt) }
  it { should respond_to(:persistence_token) }

  # Thumbnail remoto
  it_should_behave_like :has_remote_file, 'thumbnail'

  context 'Retrievers' do
    it 'find user by login or email' do
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:user)

      User.find_by_login_or_email(@user.login).should == @user
      User.find_by_login_or_email(@user.email).should == @user
    end
  end

  context '#client_applications' do
    let(:user) { User.new }
    let(:apps_example) do
      [{ "user_token" => "7I8EzS03niDeYTxgKMqsmbFSqN9ZItoEr5N7zUO2", "id" => 12,
        "name" => "Portal de aplicativos", "secret" => "xxx" }]
    end

    it "should assing #token for apps application" do
      user.client_applications = apps_example
      user.token.should == apps_example.first["user_token"]
    end

    it "should not fail with nil" do
      expect {
        user.client_applications = nil
      }.to_not raise_error
    end

    it "should work with update attributes" do
      user = FactoryGirl.create(:user)
      apps_example.first['token'] = "123"
      user.update_attributes({ client_applications: apps_example })
      user.token = "123"
    end
  end
end
