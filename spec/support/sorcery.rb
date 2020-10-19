module Sorcery
  module TestHelpers
    module Rails
      module Request
        def login_user(user = nil, email = nil, password = nil, route = nil, http_method = :post)
          binding.pry
          user ||= @user
          route ||= api_v1_authenticate_path
          email_attr = :email
          email = user.send(email_attr)
          password_attr = :password
          password = user.send(password_attr)
          #binding.pry
          send(http_method, route, params: { user: {"#{email_attr}": email, "#{password_attr}": password } })
        end
      end
    end
  end
end
