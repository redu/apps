class UntiedGeneralObserver < Untied::Consumer::Observer
  include UntiedObserverHelper
  observe(:user, :environment, :course, :space, :subject,
    :user_course_association, :from => :core)
  #observa tudo

  def after_create(payload)
    kind = payload.keys[0]
    self.send("create_#{kind}", payload)
  end

  def after_update(payload)
    kind = payload.keys[0]
    self.send("update_#{kind}", payload)
  end

  def after_destroy(payload)
    kind = payload.keys[0]
    self.send("destroy_#{kind}", payload)
  end
end