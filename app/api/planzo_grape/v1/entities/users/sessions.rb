module PlanzoGrape
  module V1
    module Entities
      module Users
        class Sessions < ::Grape::Entity
          expose :token, documentation: { type: 'String', desc: 'Auth token for user', required: true }
        end
      end
    end
  end
end
