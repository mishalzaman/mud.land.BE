require 'rails_helper'

RSpec.describe "Weatherings", type: :request do
  let(:user_session) { UserSession.create! }

  describe "GET /user_sessions/:user_session_id/weathering" do

    context "when weathering exists" do
      let!(:weathering) { Weathering.create!(user_session: user_session)}

      it "returns :ok" do
        get user_session_weathering_path(user_session)
  
        expect(response).to have_http_status(:ok)
      end
    end

    context "when weathering does not exist" do
      it "returns :not_found" do
        get user_session_weathering_path(user_session)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
