FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }

    trait :admin do
      role { 'admin' }
    end

    trait :user do
      role { 'user' }
    end
  end
end
