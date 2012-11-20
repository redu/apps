class UserSession < Authlogic::Session::Base
  # Permite que o usuário efetue o log in tanto por login como por e-mail
  find_by_login_method :find_by_login_or_email
end
