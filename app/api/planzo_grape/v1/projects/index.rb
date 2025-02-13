module PlanzoGrape
  module V1
    module Projects
      class Index < ::Grape::API
        resource :projects do
          # GET /api/v1/projects
          desc "Get all projects" do
            tags [ "projects" ]
            detail "Get all projects from planzo"
            success model: Entities::Projects::Index, code: 200, message: "Success: Users fetched successfully"
          end
          params do
            optional :name_cont_all,
                     type: String,
                     documentation: { desc: "First name of the project" }

            optional :id_eq,
                     type: Integer,
                     documentation: { desc: "ID of the project" }
            optional :include_users, type: Boolean, desc: "true to add users"
            optional :include_tasks, type: Boolean, desc: "true to add tasks"
          end

          helpers do
            def all_project
              active_params = declared(params).merge({end_date_gteq: Date.today})
              # Add pagination for better performance
              Project.eager_load(project_users: [ :user, [ :tasks ] ])
                     .ransack(active_params)
                     .result
                     .order(id: :asc)

            end
          end

          get do
            present all_project, with: Entities::Projects::Index,
                    include_users: params[:include_users],
                    include_tasks: params[:include_tasks]
          end

          # GET /api/v1/projects/:id
          desc "Get a project from planzo" do
            tags [ "projects" ]
            detail "Get all projects"
            success model: Entities::Projects::Index, code: 200, message: "Success: Projects fetched successfully"
          end
          params do
            requires :id, type: Integer, desc: "ID of the project"
            optional :include_users, type: Boolean, desc: "true to add users"
            optional :include_tasks, type: Boolean, desc: "true to add tasks"
          end
          get ":id" do
            # TODO update the query as per optional parameters we can do that, without using eagerload
            present Project.eager_load(:tasks, :users).find(params[:id]),
                    with: Entities::Projects::Index,
                    include_users: params[:include_users],
                    include_tasks: params[:include_tasks]
          end
        end
      end
    end
  end
end
