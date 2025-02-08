module PlanzoGrape
  module V1
    module Tasks
      class Root < ::Grape::API
        version 'v1', using: :path
        format 'json'
        prefix :api

        mount Index
      end
    end
  end
end
