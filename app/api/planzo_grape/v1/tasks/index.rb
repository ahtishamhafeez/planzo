module PlanzoGrape
  module V1
    module Tasks
      class Index < ::Grape::API
        resource :tasks do
          # GET /api/v1/tasks
          desc "Get all tasks" do
            tags ["tasks"]
            detail "Get all tasks"
            success model: Entities::Tasks::Index, code: 200, message: "Success: Tasks fetched successfully"
          end

          params do
            optional :project_user_user_id_eq,
                     type: Integer,
                     documentation: { desc: "ID of the project user" }
            optional :project_user_project_id_eq,
                     type: Integer,
                     documentation: { desc: "ID of the project" }
            optional :id_eq,
                     type: Integer,
                     documentation: { desc: "ID of the task" }
          end

          helpers do
            def all_tasks
              Task.joins(:project_user).ransack(declared(params)).result
            end
          end

          get do
            present all_tasks, with: Entities::Tasks::Index
          end

          # GET /api/v1/tasks/:id
          desc "Get a specific task" do
            tags ["tasks"]
            detail "Get a specific task"
            success model: Entities::Tasks::Index, code: 200, message: "Success: Task fetched successfully"
          end

          get ":id" do
            present Task.joins(:project_user).find(params[:id]), with: Entities::Tasks::Index
          end

          params do
            requires :name, type: String, desc: "Name of the task"
            requires :duration, type: Hash, desc: "Duration details" do
              requires :unit, type: String, allow_blank: false, values: Task::DURATION_UNIT,
                              desc: "Time unit (not nullable)"
              requires :period, type: Integer, allow_blank: false, values: Task::DURATIONS,
                                desc: "Time period (not nullable)"
            end
            requires :description, type: String, desc: "Description of the task"
            requires :project_id, type: Integer, desc: "Project ID"
            requires :user_id, type: Integer, desc: "User ID"
          end

          # POST /api/v1/tasks/assign
          desc "Assign a task to a user" do
            tags ["tasks"]
            detail "Task assignment to a user"
            success model: Entities::Tasks::Index, code: 200, message: "Success: Task assigned successfully to user"
          end

          post do
            project_user = ProjectUser.find_by(project_id: params[:project_id], user_id: params[:user_id])
            error!("User not assigned this project", 400) unless project_user

            task = Task.new(params.except(:project_id, :user_id).merge(project_user_id: project_user.id))
            task.valid? ? task.save : error!(task.errors.full_messages, 400)
            present task, with: Entities::Tasks::Index
          end
        end
      end
    end
  end
end
