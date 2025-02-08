module PlanzoGrape
  module V1
    module Entities
      module Tasks
        class Index < ::Grape::Entity
          expose :id, documentation: { type: 'Integer', desc: 'ID of the user', optional: true }
          expose :name, documentation: { type: 'String', desc: 'Email of the user', optional: true }
          expose :start_time, documentation: { type: 'Date', desc: 'First name of the user' }
          expose :end_time, documentation: { type: 'Date', desc: 'Last name of the user' }
          expose :duration, documentation: { type: 'String', desc: 'First name of the user' } do |task, _|
            task.formatted_duration
          end
          expose :description, documentation: { type: 'String', desc: 'Last name of the user' }
          expose :project_id, documentation: { type: 'Integer', desc: 'ID of the project' } do |task, _|
            task.project_id
          end
          expose :user_id, documentation: { type: 'Integer', desc: 'ID of the user' } do |task, _|
            task.user_id
          end
        end
      end
    end
  end
end
