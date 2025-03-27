require 'rails_helper'

RSpec.describe "Albedos", type: :request do
  let(:user_session) { UserSession.create! }

  describe "GET /user_session/:user_session_id/albedo" do
    context "when albedo exists" do
      let!(:albedo) { Albedo.create!(user_session: user_session) }

      it "returns :ok" do
        get user_session_albedo_path(user_session)

        expect(response).to have_http_status(:ok)
      end
    end

    context "when albedo does not exist" do
      it "returns :not_found" do
        get user_session_albedo_path(user_session)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
