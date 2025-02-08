module PlanzoGrape
  module V1
    module Projects
      class Create < ::Grape::API
        desc 'create a project in  planzo' do
          tags ['projects']
          detail 'Get all projects'
          success model: Entities::Projects::Index, code: 200, message: 'Success: Users fetched successfully'
        end
        resource :projects do
          params do
            requires :name, type: String, desc: 'Name of the project'
            requires :start_time, type: Date, desc: 'Start date of the project'
            requires :duration, type: Hash, desc: 'Duration details' do
              requires :unit, type: String, allow_blank: false, values: Task::DURATION_UNIT,
                              desc: 'Time unit (not nullable)'
              requires :period, type: Integer, allow_blank: false, values: Task::DURATIONS,
                                desc: 'Time period (not nullable)'
            end
            requires :description, type: String, desc: 'Description of the project'
          end

          helpers do
            def create_project
              Project.create!(declared(params))
            end
          end
          post do
            present create_project, with: Entities::Projects::Index
          end
        end
      end
    end
  end
end
