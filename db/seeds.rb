User.insert_all!([
                   { first_name: 'John', last_name: 'Doe', email: 'john@example.com', role: User.roles[:user], created_at: Time.current,
                     updated_at: Time.current },
                   { first_name: 'Jane', last_name: 'Smith', email: 'jane@example.com', role: User.roles[:user],
                     created_at: Time.current, updated_at: Time.current },
                   { first_name: 'Alice', last_name: 'Johnson', email: 'alice@example.com', role: User.roles[:user],
                     created_at: Time.current, updated_at: Time.current }
                 ])

User.create!(
  first_name: 'Admin',
  last_name: 'User',
  email: 'admin@example.com',
  password: 'password',
  role: User.roles[:admin]
)

Project.insert_all!([
                      { name: 'Project 1', start_time: 1.day.ago,
                        duration: { unit: Project::DURATION_UNIT.sample, period: Project::DURATIONS.sample }, created_at: Time.current, updated_at: Time.current },
                      { name: 'Project 2', start_time: 1.day.ago,
                        duration: { unit: Project::DURATION_UNIT.sample, period: Project::DURATIONS.sample }, created_at: Time.current, updated_at: Time.current },
                      { name: 'Project 3', start_time: 1.day.ago,
                        duration: { unit: Project::DURATION_UNIT.sample, period: Project::DURATIONS.sample }, created_at: Time.current, updated_at: Time.current }
                    ])

users = User.user.to_a
projects = Project.order(:id).to_a

project_users = []
projects.each_with_index do |project, index|
  project_users << { project_id: project.id, user_id: users[index % users.size].id, created_at: Time.current,
                     updated_at: Time.current }
end
ProjectUser.insert_all!(project_users)

project_users = ProjectUser.all.to_a
tasks = []
project_users.each_with_index do |project_user, index|
  tasks << {
    project_user_id: project_user.id,
    name: "Task #{index + 1}",
    duration: { unit: Task::DURATION_UNIT.sample, period: Task::DURATIONS.sample },
    description: Faker::Lorem.paragraph,
    created_at: Time.current,
    updated_at: Time.current
  }
end
Task.insert_all!(tasks)

puts "Seeded database with #{User.count} users, #{Project.count} projects, #{ProjectUser.count} project_users, and #{Task.count} tasks."
