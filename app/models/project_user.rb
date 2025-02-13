class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :tasks
  scope :active, -> { where(deleted_at: nil) }

  validates :user_id, uniqueness: { scope: :project_id, message: "has already been assigned to this project" }

  # Soft delete method
  def soft_delete
    update(deleted_at: Time.current)
  end

  # Ensure tasks can't be assigned if user is soft-deleted
  def can_assign_tasks?
    deleted_at.nil?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id user_id project_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[project user tasks]
  end
end
