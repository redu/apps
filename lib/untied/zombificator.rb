module Untied
  module Zombificator
    module ActAsZombie
      # Modulo que adiciona suporte a modelos zombies. Se um modelo for criado sem validação
      # ele automaticamente é marcado como zombie, caso a validação seja feita,
      # o modelo perde essa tag se não ocorrer nenhum erro.
      extend ActiveSupport::Concern

      module ClassMethods
        def acts_as_zombie
          attr_accessible :zombie

          # Modelos zombies não devem aparecer em consultas normais.
          default_scope where("#{self.table_name}.zombie is FALSE")

          after_initialize { self.zombie = true if self.zombie.nil? }
          after_validation { self.zombie = false if self.errors.empty? }
        end
      end
    end
  end
end