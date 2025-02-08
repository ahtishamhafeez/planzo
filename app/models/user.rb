class User < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :tasks, through: :project_users

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { scope: :role }
  validates :role, presence: true

  enum role: { user: 'user', admin: 'admin' }, _suffix: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id first_name last_name email role]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[projects tasks project_users]
  end
end
