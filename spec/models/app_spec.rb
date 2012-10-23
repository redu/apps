require 'spec_helper'

describe App do
  # Nome
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Categorias
  it {should have_many(:app_category_associations)}
  it {should have_many(:categories).through(:app_category_associations)}

  # Autor
  it { should respond_to(:author) }
  it { should validate_presence_of(:author) }

  # Idioma
  it { should respond_to(:language) }
  it { should validate_presence_of(:language) }

  # Objetivo
  it { should respond_to(:objective) }

  # Sinopse
  it { should respond_to(:synopsis) }

  # Descrição
  it { should respond_to(:description) }

  # Classificação
  it { should respond_to(:classification) }

  # País de origem
  it { should respond_to(:country) }

  # Publicador(es)
  it { should respond_to(:publishers) }

  # Quem submeteu
  it { should respond_to(:submitters) }

  # Endereço de origem
  it { should respond_to(:url) }

  # Detentor dos direitos autorais
  it { should respond_to(:copyright) }

  # Thumbnail
  it { should have_attached_file(:thumbnail) }

  # Comentários
  it { should have_many(:comments) }

  # Aplicativos favoritos de usuários (ou simplesmente aplicativos de usuários)
  it { should have_many(:user_app_associations) }
  it { should have_many(:users).through(:user_app_associations) }

  # Total de visualizações do aplicativo
  it { should respond_to(:views) }

  # Screenshots do aplicativo
  it { should have_many(:screen_shots) }

  describe "has many categories" do
    before do
      @app = FactoryGirl.create(:app)
      @category = Category.create(name: "Rock School")
    end

    it "should not destroy app when associated categories are destroyed" do
      expect {
        @category.destroy
      }.to_not change(App, :count)
    end
  end
end
