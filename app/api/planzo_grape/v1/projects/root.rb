module PlanzoGrape
  module V1
    module Projects
      class Root < ::Grape::API
        version 'v1', using: :path
        format 'json'
        prefix :api

        mount Index
        mount Create
      end
    end
  end
end
