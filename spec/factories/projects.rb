FactoryBot.define do
  factory :project do
    name { Faker::App.name } # Random project name
    start_time { Faker::Date.backward(days: 30) } # Random start date within the past 30 days
    # Random duration between 1 and 12 months
    duration do
      { unit: Project::DURATION_UNIT.sample, period: Project::DURATIONS.sample }
    end
    # Trait to create associated users through project_users
    trait :with_users do
      after(:create) do |project|
        create_list(:user, 3).each do |user|
          puts "Creating project_user for user #{user.id} and project #{project.id}"
          create(:project_user, project_id: project.id, user_id: user.id)
        end
      end
    end

    # Trait to create associated tasks through project_users
    trait :with_tasks do
      after(:create) do |project|
        create_list(:task, 3, project_user: project.project_users.first)
      end
    end
  end
end
