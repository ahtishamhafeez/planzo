class Project < ApplicationRecord
  include Durationable

  has_many :project_users, dependent: :destroy
  has_many :tasks, through: :project_users
  has_many :users, through: :project_users

  validates :name, :start_time, presence: true

  def is_active
    start_time <= Time.now && Time.now <= end_time
  end

  def end_time
    return nil if duration.blank?

    @end_time ||= start_time.to_date + duration['period'].send(duration['unit'].downcase)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name start_time end_time duration description]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[tasks project_users users]
  end
end
