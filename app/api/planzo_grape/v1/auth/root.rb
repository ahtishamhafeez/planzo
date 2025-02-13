module PlanzoGrape
  module V1
    module Auth
      class Root < ::Grape::API
        version "v1", using: :path
        format "json"
        prefix :api

        mount Session
      end
    end
  end
end
