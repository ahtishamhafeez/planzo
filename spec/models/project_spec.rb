require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { FactoryBot.create(:project, start_time: Time.current, duration: { "period" => 1, "unit" => "day" }) }

  describe 'Associations' do
    it { is_expected.to have_many(:project_users).dependent(:destroy) }
    it { is_expected.to have_many(:tasks).through(:project_users) }
    it { is_expected.to have_many(:users).through(:project_users) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_time) }
  end

  describe 'Callbacks' do
    it 'sets end_date before saving if duration is present' do
      subject.save
      expected_end_date = subject.start_time.to_date + subject.duration["period"].send(subject.duration["unit"].downcase)
      expect(subject.end_date).to eq(expected_end_date)
    end
  end

  describe 'Scopes' do
    let!(:active_project) { FactoryBot.create(:project, start_time: Date.today - 5.days, duration: { "period" => 5, "unit" => "day" }) }
    let!(:inactive_project) { FactoryBot.create(:project, start_time: Date.today - 10.days, duration: { "period" => 1, "unit" => "day" }) }

    it 'returns only active projects' do
      expect(Project.active).to include(active_project)
      expect(Project.active).not_to include(inactive_project)
    end
  end

  describe 'Methods' do
    it 'returns true if project is active' do
      subject = FactoryBot.create(:project, start_time: Date.today,
                                  duration: { "period" => 5, "unit" => "day" })
      expect(subject.is_active).to be true
    end

    it 'returns false if project is inactive' do
      subject = FactoryBot.create(:project, start_time: Date.today - 5.day,
                                  duration: { "period" => 2, "unit" => "day" })
      expect(subject.is_active).to be false
    end

    it 'returns ransackable attributes' do
      expect(Project.ransackable_attributes).to match_array(%w[id name start_time end_date duration description])
    end

    it 'returns ransackable associations' do
      expect(Project.ransackable_associations).to match_array(%w[tasks project_users users])
    end
  end
end
