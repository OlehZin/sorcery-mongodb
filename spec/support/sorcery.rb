module Sorcery
  module TestHelpers
    module Rails
      module Request
        def login_user(user = nil, password = '12345678', route = nil, http_method = :post)
          user ||= @user
          route ||= sessions_path
          email_attr = :email
          email = user.send(email_attr)
          password_attr = :password
          send(http_method, route , params: { user: {"#{email_attr}": email, "#{password_attr}": password } })
        end
      end
    end
  end
end
