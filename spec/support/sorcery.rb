module Sorcery
  module TestHelpers
    module Rails
      module Request

        def login_user(email = nil, password = nil, route = sessions_path, http_method = :post)
          send(http_method, route, params: { user: {email: email, password: password } })
        end

        # def login_api_user(email = nil, password = nil, route = api_v1_authenticate_path, http_method = :post)
        #   send(http_method, route, params: { user: {email: email, password: password } })
        # end
      end
    end
  end
end
#
