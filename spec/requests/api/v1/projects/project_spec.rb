require "rails_helper"

RSpec.describe "Projects API", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_project_params) do
    {
      name: "New Project",
      start_time: Date.today,
      duration: { "unit": "days", "period": 5 },
      description: "This is a test project"
    }
  end

  describe "POST /api/v1/projects" do
    context "when valid parameters are provided" do
      it "creates a new project" do
        post "/api/v1/projects", params: valid_project_params
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response["name"]).to eq("New Project")
        expect(json_response["description"]).to eq("This is a test project")
      end
    end

    context "when required parameters are missing" do
      it "returns an error if name is missing" do
        invalid_params = valid_project_params.except(:name)
        post "/api/v1/projects", params: invalid_params

        expect(response).to have_http_status(:not_acceptable)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("name is missing")
      end

      it "returns an error if duration unit is invalid" do
        invalid_params = valid_project_params.merge(duration: { unit: "invalid_unit", period: 5 })
        post "/api/v1/projects", params: invalid_params

        expect(response).to have_http_status(:not_acceptable)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("duration[unit] does not have a valid value")
      end
    end
  end

  describe "POST /api/v1/projects/:id/users/:user_id" do
    let(:project) { FactoryBot.create(:project, valid_project_params) }

    context "when valid project and user IDs are provided" do
      it "assigns a user to the project" do
        post "/api/v1/projects/#{project.id}/users/#{user.id}"

        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to eq(project.id)
      end
    end

    context "when an invalid project ID is provided" do
      it "returns an error" do
        post "/api/v1/projects/999999/users/#{user.id}"
        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Validation failed: Project must exist")
      end
    end

    context "when an invalid user ID is provided" do
      it "returns an error" do
        post "/api/v1/projects/#{project.id}/users/999999"

        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("Validation failed: User must exist")
      end
    end
  end
end
