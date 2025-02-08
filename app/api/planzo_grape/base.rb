require 'grape-swagger'

module PlanzoGrape
  class Base < Grape::API
    mount V1::Base
  end
end
