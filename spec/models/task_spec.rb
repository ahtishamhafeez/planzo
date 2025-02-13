require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, start_time: Date.today + 5.days,
                                    duration: { "unit" => "day", "period" => 10 }) }
  let(:project_user) { FactoryBot.create(:project_user, user: user, project: project) }

  describe "validations" do
    it "is valid with valid attributes" do
      task = FactoryBot.build(:task, project_user: project_user,
                              name: "Test Task", description: "Task description",
                              duration: { "unit" => "day", "period" => 5 })
      expect(task).to be_valid
    end

    it "is invalid without a name" do
      task = FactoryBot.build(:task, project_user: project_user, name: nil)
      expect(task).not_to be_valid
      expect(task.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a description" do
      task = FactoryBot.build(:task, project_user: project_user, description: nil)
      expect(task).not_to be_valid
      expect(task.errors[:description]).to include("can't be blank")
    end
  end

  describe "duration validation" do
    it "is invalid if duration exceeds project duration" do
      task = FactoryBot.build(:task, project_user: project_user, duration: { "unit" => "day", "period" => 15 })
      task.validate
      expect(task.errors[:duration]).to include("Can not add duration more than the project duration")
    end

    it "is invalid if duration unit does not match project duration unit" do
      task = FactoryBot.build(:task, project_user: project_user, duration: { "unit" => "week", "period" => 5 })
      task.validate
      expect(task.errors[:duration]).to include("Can not add duration more than the project duration")
    end
  end

  describe "project status validation" do
    let(:inactive_project) do
      FactoryBot.create(:project, start_time: Date.today - 5.days,
                        duration: { "unit" => "day", "period" => 1 })
    end
    let(:inactive_project_user) { FactoryBot.create(:project_user, project: inactive_project, user: user) }

    it "prevents saving if the project is not active" do
      task = FactoryBot.build(:task, project_user: inactive_project_user, duration: { "unit" => "day", "period" => 1 })
      task.validate
      expect(task.errors[:base]).to include("Cannot add tasks to an inactive project")
    end

    it "allows saving if the project is active" do
      task = FactoryBot.build(:task, project_user: project_user, duration: { "unit" => "day", "period" => 3 })
      expect(task).to be_valid
    end
  end
end
