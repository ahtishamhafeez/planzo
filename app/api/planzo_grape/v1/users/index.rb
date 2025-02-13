module PlanzoGrape
  module V1
    module Users
      class Index < ::Grape::API
        resource :users do
          desc "Get all users" do
            tags ["users"]
            detail "Get all users"
            success model: Entities::Users::Index, code: 200, message: "Success: Users fetched successfully"
          end
          params do
            optional :first_name_cont_all,
                     type: String,
                     documentation: { desc: "First name of the user" }

            optional :id_eq,
                     type: Integer,
                     documentation: { desc: "ID of the user" }
          end

          helpers do
            def all_users
              User.user_role.ransack(declared(params)).result
            end
          end

          get do
            present all_users, with: Entities::Users::Index
          end
          desc "Get a user" do
            tags ["users"]
            detail "Get a user by id"
            success model: Entities::Users::Index, code: 200, message: "Success: User fetched successfully"
          end
          params do
            requires :id, type: Integer, desc: "Id of the user"
          end
          get ":id" do
            present User.includes(project_users: [:project, :tasks]).find(params[:id]), with: Entities::Users::Index,
                    include_tasks: true
          end

          params do
            requires :first_name, type: String, desc: "First name of the user"
            requires :last_name, type: String, desc: "Last name of the user"
            requires :email, type: String, desc: "Email address of the user"
            requires :role, type: String, values: User.roles.excluding("admin").keys, desc: "Role of the user"
            requires :password, type: String, desc: "Password of the user"
          end

          post do
            User.new(declared(params))
          end

          delete ":id" do
            user = User.find(params[:id])
            if user.destroy
              present status: "success", message: "User deleted successfully"
            else
              present status: "error", message: "User not deleted"
            end
          end
        end
      end
    end
  end
end
