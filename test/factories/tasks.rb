FactoryBot.define do
  factory :task do
    project_user
    name { Faker::Lorem.sentence }
    start_time { nil }
    end_time { nil }
    duration { { unit: Task::DURATION_UNIT.sample, period: Task::DURATIONS.sample } }
    description { Faker::Lorem.paragraph }
  end
end
