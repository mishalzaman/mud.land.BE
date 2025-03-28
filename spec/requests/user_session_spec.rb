require 'rails_helper'

RSpec.describe "UserSessionsController", type: :request do
  describe "POST /user_sessions" do
    it "creates a user session" do
      post "/user_sessions"
      expect(response).to have_http_status(:ok).or have_http_status(:created)
    end
  end

  describe "DELETE /user_sessions/:id" do
    it "destroys a user session" do
      session_record = UserSession.create!
      delete "/user_sessions/#{session_record.id}"
      expect(response).to have_http_status(:ok).or have_http_status(:no_content)
    end
  end

  describe "GET /user_sessions/:id/mud" do
    it "returns all data associated with user session" do
      user_session = UserSession.create!
      get "/user_sessions/#{user_session.id}/mud"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("layers", "export", "water", "weathering", "albedo")
    end
  end
end
