class Project < ApplicationRecord
  include Durationable

  has_many :project_users, dependent: :destroy
  has_many :tasks, through: :project_users
  has_many :users, through: :project_users

  validates :name, :start_time, presence: true
  before_save :save_end_time, if: -> { duration.present? && new_record? }

  scope :active, -> { where("start_time::date <= ? AND end_date::date >= ?", Date.today, Date.today) }

  def is_active
    Date.today <= end_date
  end

  def save_end_time
    self.end_date = start_time.to_date + duration["period"].send(duration["unit"].downcase)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name start_time end_date duration description]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[tasks project_users users]
  end
end
