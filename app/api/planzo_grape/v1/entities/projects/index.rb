module PlanzoGrape
  module V1
    module Entities
      module Projects
        class Index < ::Grape::Entity
          expose :id, documentation: { type: 'Integer', desc: 'ID of the project', required: true }
          expose :name, documentation: { type: 'String', desc: 'Name of the user', required: true }
          expose :start_time, documentation: { type: 'Date', desc: 'Start date of the project' }
          expose :duration, documentation: { type: 'String', desc: 'Duration of the project' } do |project|
            project.formatted_duration
          end
          expose :description, documentation: { type: 'String', desc: 'Description of the project' }
          expose :tasks, with: Entities::Tasks::Index,
                         documentation: { type: 'Array', desc: 'Tasks of the project' } do |project, _|
            project.tasks
          end
          expose :users, with: Entities::Users::Index,
                         documentation: { type: 'Array', desc: 'Users of the project' } do |project, _|
            project.users
          end
          expose :is_active, documentation: { type: 'Boolean', desc: 'Status of the project' } do |project, _|
            project.is_active
          end
        end
      end
    end
  end
end
