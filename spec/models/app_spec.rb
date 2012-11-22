# encoding: utf-8
require 'spec_helper'

describe App do
  # AID (ID do aplicativo no Redu)
  it { should respond_to(:aid) }
  it { should validate_presence_of(:aid) }
  it { should validate_uniqueness_of(:aid) }

  # Nome
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Aulas em que o aplicativo é utilizado
  it { should have_many(:lectures) }

  # Categorias
  it { should have_many(:app_category_associations).dependent(:destroy) }
  it { should have_many(:categories).through(:app_category_associations) }

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
  it { should have_many(:comments).dependent(:destroy) }

  # Aplicativos favoritos de usuários (ou simplesmente aplicativos de usuários)
  it { should have_many(:user_app_associations).dependent(:destroy) }
  it { should have_many(:users).through(:user_app_associations) }

  # Total de visualizações do aplicativo
  it { should respond_to(:views) }

  # Screenshots do aplicativo
  it { should have_many(:screen_shots).dependent(:destroy) }

  # Id do app no redu
  it { should respond_to(:core_id) }

  # Url do objeto do aplicativo
  it { should respond_to(:core_url) }

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

  # Rating
  describe "AR Reputation System" do
    it { should respond_to(:has_evaluation?) }
    it { should respond_to(:add_evaluation) }
    it { should respond_to(:update_evaluation) }
    it { should respond_to(:add_or_update_evaluation) }
    it { should respond_to(:delete_evaluation) }
    it { should respond_to(:reputation_for) }
    it { should respond_to(:evaluators_for) }
  end

  it "should have set 1 as minimum rating value" do
    App::MIN_RATING.should == 1
  end

  it "should have set 5 as maximum rating value" do
    App::MAX_RATING.should == 5
  end

  describe :is_valid_rating_value do
    before do
      @valid_values = [1, 2, 3, 4, 5]
      @invalid_values = [-50, -5, -1, 0, 6, 10, 50]
    end

    it "shouldn't accept invalid values" do
      @invalid_values.each do |invalid_value|
        App.is_valid_rating_value?(invalid_value).should be_false
      end
    end

    it "should accept valid values" do
      @valid_values.each do |valid_value|
        App.is_valid_rating_value?(valid_value).should be_true
      end
    end
  end
end
