# frozen_string_literal: true

module PlanzoGrape
  module V1
    module ExceptionHandler
      extend ActiveSupport::Concern

      included do
        rescue_from :all do |e|
          if e.instance_of?(::Grape::Exceptions::ValidationErrors)
            error!(e.message, 406)
          elsif e.instance_of?(::RuntimeError)
            error!("Invalid Access / Unauthorized", 401)
          elsif e.instance_of?(::ActiveRecord::RecordNotFound)
            error!(e.message, 404)
          elsif e.instance_of?(::ActionController::BadRequest)
            error!(e.message, 400)
          elsif e.instance_of?(::ActiveRecord::RecordInvalid)
            error!(e.message, 400)
          else
            Rails.logger.error "\n#{e.class.name} (#{e.message}):"
            e.backtrace.each { |line| Rails.logger.error line }
            error!("Internal server error", 500)
          end
        end
      end
    end
  end
end