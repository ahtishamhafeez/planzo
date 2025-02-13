class Task < ApplicationRecord
  include Durationable

  belongs_to :project_user
  has_one :project, through: :project_user
  has_one :user, through: :project_user

  validates :name, :description, presence: true
  validate :validate_if_project_is_active
  validate :validate_duration_insertion
  validate :ensure_user_not_deleted

  def validate_if_project_is_active
    project_end_date = project.end_date + project.duration["period"].send(project.duration["unit"])
    if Date.today > project_end_date
      errors.add(:base, "Cannot add tasks to an inactive project")
    end
  end

  def validate_duration_insertion
    if project.start_time + duration["period"].send(duration["unit"]) > project.end_date
      errors.add(:duration, "Can not add duration more than the project duration")
    end
  end

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

  private

  def ensure_user_not_deleted
    if user.project_users.find_by(project: project)&.deleted_at.present?
      errors.add(:user, "cannot be assigned tasks because they have been removed from the project")
    end
  end
end
