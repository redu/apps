module BaseModel
  extend ActiveSupport::Concern

  module ClassMethods
    def zombify
      attr_accessible :zombie
      after_initialize { self.zombie = true if self.zombie.nil? }
      after_validation { self.zombie = false if self.errors.empty? }
    end
  end
end
