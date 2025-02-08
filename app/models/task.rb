class Task < ApplicationRecord
  include Durationable

  belongs_to :project_user
  has_one :project, through: :project_user
  has_one :user, through: :project_user

  validates :name, :description, presence: true

  def user_id
    @user_id ||= project_user.user_id
  end

  def project_id
    @project_id ||= project_user.project_id
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name start_time end_time duration description]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[project_user user project]
  end
end
