class UntiedGeneralObserver < UntiedObserverHelper
  # Observa todos os objetos relevantes do redu, faz uso do helper para criação
  # dos modelos

  def initialize
    super

    elements = self.config.values.collect {|v| v['name'].underscore.to_sym }
    self.class.observe(*elements, :from => :core)
  end

  def after_create(payload)
    kind = payload.keys[0]
    self.create_proxy(kind, payload.values[0])
  end

  def after_update(payload)
    kind = payload.keys[0]
    self.update_proxy(kind, payload.values[0])
  end

  def after_destroy(payload)
    kind = payload.keys[0]
    self.destroy_proxy(kind, payload.values[0])
  end
end
