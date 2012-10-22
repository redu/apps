FactoryGirl.define do
  factory :app do
    sequence(:name) { |n| "Recurso Educacional Aberto #{n}" }
    author "Redu Educational Technologies"
    language "Portugues (pt_BR)"

    factory :complete_app do
      objective 'Etiam massa felis, fermentum et semper ac, dictum eget arcu.'
      synopsis 'Praesent rhoncus magna vel dui malesuada vel trisque tertor' + \
        'vehicula. Cras ultrices accumsan nunc, at pretium risus oliquam eu.'
      description 'Lorem ipsum dolor sit amet, consectetur adpiscing elit.'
      classification 'Animacao / Simulacao'
      country 'Estados Unidos (US)'
      publishers 'United Nations'
      submitters 'Ministerio da Educacao (Brasil)'
      url 'objetoseducacionais2.mev.gov.br'
      copyright 'UNESCO'
      thumbnail { open('app/assets/images/app_thumb.png') }

      after(:create) do |app|
        app.screen_shots << FactoryGirl.create(:screen_shot, :app => app)
      end

      factory :complete_app_with_comments do
        after(:create) do |app|
          2.times do 
            app.comments << FactoryGirl.create(:specialized_comment, :app => app)
            app.comments << FactoryGirl.create(:comment, :app => app)
          end
          app.comments << FactoryGirl.create(:common_comment, :app => app)
        end
      end
    end
  end
end
