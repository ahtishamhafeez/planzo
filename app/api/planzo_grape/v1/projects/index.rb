module PlanzoGrape
  module V1
    module Projects
      class Index < ::Grape::API
        resource :projects do
          # GET /api/v1/projects
          desc 'Get all projects' do
            tags ['projects']
            detail 'Get all projects from planzo'
            success model: Entities::Projects::Index, code: 200, message: 'Success: Users fetched successfully'
          end
          params do
            optional :name_cont_all,
                     type: String,
                     documentation: { desc: 'First name of the project' }

            optional :id_eq,
                     type: Integer,
                     documentation: { desc: 'ID of the project' }
          end

          helpers do
            def all_users
              Project.eager_load(:tasks, :users).ransack(declared(params)).result
            end
          end

          get do
            present all_users, with: Entities::Projects::Index
          end

          # GET /api/v1/projects/:id
          desc 'Get a project from planzo' do
            tags ['projects']
            detail 'Get all projects'
            success model: Entities::Projects::Index, code: 200, message: 'Success: Projects fetched successfully'
          end
          params do
            requires :id, type: Integer, desc: 'ID of the project'
          end
          get ':id' do
            present Project.eager_load(:tasks, :users).find(params[:id]), with: Entities::Projects::Index
          end
        end
      end
    end
  end
end
