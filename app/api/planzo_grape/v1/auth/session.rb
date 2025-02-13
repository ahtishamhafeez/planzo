module PlanzoGrape
  module V1
    module Auth
      class Session < ::Grape::API
        desc "Sign in user" do
          tags ["auth"]
          detail "Get user token"
          success model: Entities::Users::Sessions, code: 200, message: "Success: Users logged in successfully"
        end
        resource :users do
          params do
            requires :email, type: String, desc: "Email address of the user"
            requires :password, type: String, desc: "Password of the user"
          end

          post "auth" do
            user = User.find_by(email: params[:email])
            if user&.authenticate(params[:password])
              token = Base64.strict_encode64("#{user.email}:#{params[:password]}")
              redirect_to = user.admin_role? ? "/dashboard/#{user.role}" : "/dashboard/#{user.role}/#{user.id}"
              { token: "Basic #{token}", user: user,  redirect_to: redirect_to }
            else
              error!("Invalid email or password", 401)
            end
          end
        end
      end
    end
  end
end
