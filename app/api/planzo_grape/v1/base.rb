module PlanzoGrape
  module V1
    class Base < ::Grape::API
      include ExceptionHandler
      mount Users::Root
      mount Projects::Root
      mount Tasks::Root
      mount Auth::Root
      helpers do
        def authenticate!
          # TODO implement only doorkeeper solution with expirable and refreshable tokens, this is for demo
          return if unprotected_paths.include?(request.path)
          error!("Authorization Failed", 401) unless current_user
        end
        def unprotected_paths
          [
            "/api/v1/users/auth",
          ]
        end
        def current_user
          return @current_user if @current_user

          auth = request.headers["Authorization"]
          return if auth.blank?
          token = auth.gsub(/Token token="/, "").gsub(/"$/, "")

          auth_type, encoded_credentials = token.split(" ", 2)
          return unless auth_type == "Basic" && encoded_credentials
 
          email, password = Base64.decode64(encoded_credentials).split(":", 2)
          user = User.find_by(email: email)

          if user&.authenticate(password)
            @current_user = user
          else
            nil
          end
        end
      end
      add_swagger_documentation \
        base_path: "/",
        title: "Planzo API",
        doc_version: "v1",
        add_version: true,
        api_documentation: { desc: "API documentation for Planzo" },
        hide_documentation_path: true,
        consumes: %w[application/json application/x-www-form-urlencoded],
        produces: %w[application/json application/octet-stream], # for downloading files or stream apis
        info: {
          title: "Planzo API",
          description: "API documentation for Planzo",
          contact_email: "ahtisham232@gmail.com",
          contact_name: "Ahtisham Qazi",
          contact: "Planzo Team"
        }
    end
  end
end
