require 'rails_helper'

RSpec.describe "UserSessionsController", type: :request do
  describe "POST /user_session" do
    it "creates a user session" do
      post "/user_sessions"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /user_sessions/:id" do
    it "destroys a user session" do
      session_record = UserSession.create!
      delete "/user_sessions/#{session_record.id}"
      expect(response).to have_http_status(:ok)
    end
  end
end
