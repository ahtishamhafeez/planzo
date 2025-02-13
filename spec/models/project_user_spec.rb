require 'rails_helper'

RSpec.describe ProjectUser, type: :model do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.create(:project_user, project: project, user: user) }
  it "allows a user to be assigned to a project" do
    expect(subject).to be_valid
  end

  it "does not allow a user to be assigned to the same project twice" do
    FactoryBot.create(:project_user, project: project, user: user)
    duplicate_project_user = FactoryBot.build(:project_user, project: project, user: user)

    expect(duplicate_project_user).not_to be_valid
    expect(duplicate_project_user.errors[:user_id]).to include("has already been assigned to this project")
  end
end
