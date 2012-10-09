require 'spec_helper'

describe App do
  # Nome
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

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
  it { should have_and_belong_to_many(:users) }
end
