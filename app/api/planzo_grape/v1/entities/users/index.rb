module PlanzoGrape
  module V1
    module Entities
      module Users
        class Index < ::Grape::Entity
          expose :id, documentation: { type: "Integer", desc: "ID of the user", required: true }
          expose :email, documentation: { type: "String", desc: "Email of the user", required: true }
          expose :first_name, documentation: { type: "String", desc: "First name of the user" }
          expose :last_name, documentation: { type: "String", desc: "Last name of the user" }
          expose :role, documentation: { type: "String", desc: "Role of the user" }
          expose :projects, using: Entities::Projects::Index,
                 documentation: { type: "Array", desc: "Projects of the user" } do |user, options|
            Entities::Projects::Index
              .represent(user.projects, include_tasks: options[:include_tasks]).as_json
          end
          expose :assigned_projects do |user, options|
            user.project_users.active.select(:project_id)
          end
        end
      end
    end
  end
end
