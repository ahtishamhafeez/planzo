class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :tasks, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[id user_id project_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[project user tasks]
  end
end
