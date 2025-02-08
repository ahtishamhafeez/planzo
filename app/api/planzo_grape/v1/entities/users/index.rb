module PlanzoGrape
  module V1
    module Entities
      module Users
        class Index < ::Grape::Entity
          expose :id, documentation: { type: 'Integer', desc: 'ID of the user', required: true }
          expose :email, documentation: { type: 'String', desc: 'Email of the user', required: true }
          expose :first_name, documentation: { type: 'String', desc: 'First name of the user' }
          expose :last_name, documentation: { type: 'String', desc: 'Last name of the user' }
          expose :role, documentation: { type: 'String', desc: 'Role of the user' }
        end
      end
    end
  end
end
