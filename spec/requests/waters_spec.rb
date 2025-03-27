require 'rails_helper'

RSpec.describe "Waters", type: :request do
  let(:user_session) { UserSession.create! }

  describe "GET /user_session/:user_session_id/water" do
    context "when water exists" do
      let!(:water) { Water.create!(user_session: user_session) }

      it "returns :ok" do
        get user_session_water_path(user_session)

        expect(response).to have_http_status(:ok)
      end
    end

    context "when water does not exist" do
      it "returns :not_found" do
        get user_session_water_path(user_session)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
