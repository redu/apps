class UntiedGeneralObserver < Untied::ObserverHelper
  # Observa todos os objetos relevantes do redu, faz uso do helper para criação
  # dos modelos

  observe(:user, :environment, :course, :space, :subject,
    :user_course_association, :user_environment_association, :from => :core)
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
