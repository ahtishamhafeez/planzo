module PlanzoGrape
  module V1
    module Entities
      module Projects
        class Index < ::Grape::Entity
          expose :id, documentation: { type: "Integer", desc: "ID of the project", required: true }
          expose :name, documentation: { type: "String", desc: "Name of the user", required: true }
          expose :start_time, documentation: { type: "Date", desc: "Start date of the project" }
          expose :duration, documentation: { type: "String", desc: "Duration of the project" } do |project, _|
            project.respond_to?(:formatted_duration) ? project.formatted_duration : project[:duration]
          end
          expose :description, documentation: { type: "String", desc: "Description of the project" }
          expose :tasks, with: Entities::Tasks::Index, documentation: { type: "Array", desc: "Tasks of the project" },
                 if: ->(project, options) { options[:include_tasks] } do |project, op|
            # TODO its not correct and needs to be managed properly, due to time shortage for now it stays
            if project.is_a? Hash
              Project.find(project[:id]).tasks
            else
              project.tasks
            end
          end

          expose :users, with: Entities::Users::Index,
                         documentation: { type: "Array", desc: "Users of the project" },
                 if: ->(project, options) { options[:include_users] } do |project, _|
            project.respond_to?(:users) ? project.users : []
          end
          expose :is_active, documentation: { type: "Boolean", desc: "Status of the project" } do |project, _|
            project.respond_to?(:is_active) ? project.is_active : project[:is_active]
          end
        end
      end
    end
  end
end
