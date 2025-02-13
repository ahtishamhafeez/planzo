require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  describe 'Associations' do
    it { should have_many(:project_users).dependent(:destroy) }
    it { should have_many(:projects).through(:project_users) }
    it { should have_many(:tasks).through(:project_users) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:role) }
  end

  describe 'Enum' do
    it 'defines role enum' do
      expect(subject).to define_enum_for(:role).with_values(user: 0, admin: 1).with_suffix
    end
  end

  describe 'Traits' do
    subject { FactoryBot.create(:user, :admin) }
    it 'creates an admin user' do
      expect(subject.role).to eq('admin')
    end
  end

  describe 'Methods' do
    it 'returns ransackable attributes' do
      expect(User.ransackable_attributes).to match_array(%w[id first_name last_name email role])
    end

    it 'returns ransackable associations' do
      expect(User.ransackable_associations).to match_array(%w[projects tasks project_users])
    end
  end
end
