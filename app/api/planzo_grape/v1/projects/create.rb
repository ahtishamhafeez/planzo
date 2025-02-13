module PlanzoGrape
  module V1
    module Projects
      class Create < ::Grape::API

        resource :projects do
          desc "create a project in  planzo" do
            tags [ "projects" ]
            detail "Get all projects"
            success model: Entities::Projects::Index, code: 200, message: "Success: Users fetched successfully"
          end
          params do
            requires :name, type: String, desc: "Name of the project"
            requires :start_time, type: Date, desc: "Start date of the project"
            requires :duration, type: Hash, desc: "Duration details" do
              requires :unit, type: String, allow_blank: false, values: Task::DURATION_UNIT,
                              desc: "Time unit (not nullable)"
              requires :period, type: Integer, allow_blank: false, values: Task::DURATIONS,
                                desc: "Time period (not nullable)"
            end
            requires :description, type: String, desc: "Description of the project"
          end

          helpers do
            def create_project
              Project.create!(declared(params))
            end
          end
          post do
            present create_project, with: Entities::Projects::Index
          end

          desc "assign a project to user planzo" do
            tags [ "projects" ]
            detail "Assign a project"
            success model: Entities::Projects::Index, code: 200, message: "Success: Project assigned successfully"
          end

          params do
            requires :id, type: Integer
            requires :user_id, type: Integer
          end

          post ":id/users/:user_id" do
            project = ::Projects::AssignUser.new(params[:id], params[:user_id]).call
            present project, with: Entities::Projects::Index
          end

          desc "un assign a project to user planzo" do
            tags [ "projects" ]
            detail "Remove user from a project"
            success code: 200, message: "Project unassigned successfully"
          end

          delete ":id/users/:user_id" do
            ::Projects::AssignUser.new(params[:id], params[:user_id], false).call
            present({ code: 200, message: 'Project unassigned successfully' })
          end
        end
      end
    end
  end
end
