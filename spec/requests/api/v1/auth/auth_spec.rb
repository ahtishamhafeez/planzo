require "rails_helper"

RSpec.describe "User Authentication", type: :request do
  let(:user) { FactoryBot.create(:user, email: "test@example.com", password: "password123") }

  describe "POST /users/auth" do
    context "when credentials are valid" do
      it "returns a valid authentication token" do
        post "/api/v1/users/auth", params: { email: user.email, password: "password123" }

        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key("token")
        expect(json_response["token"]).to match(/^Basic /)
      end
    end

    context "when credentials are invalid" do
      it "returns an unauthorized error for wrong password" do
        post "/api/v1/users/auth", params: { email: user.email, password: "wrongpassword" }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid email or password")
      end

      it "returns an unauthorized error for non-existing email" do
        post "/api/v1/users/auth", params: { email: "invalid@example.com", password: "password123" }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid email or password")
      end
    end

    context "when parameters are missing" do
      it "returns an error when email is missing" do
        post "/api/v1/users/auth", params: { password: "password123" }

        expect(response).to have_http_status(:not_acceptable)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("email is missing")
      end

      it "returns an error when password is missing" do
        post "/api/v1/users/auth", params: { email: user.email }

        expect(response).to have_http_status(:not_acceptable)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to include("password is missing")
      end
    end
  end
end
