require 'rails_helper'

RSpec.describe "Exports", type: :request do
  let(:user_session) { UserSession.create! }

  describe "GET /user_session/:user_session_id/export" do
    context "when export exists" do
      let!(:export) { Export.create!(user_session: user_session) }

      it "returns :ok" do
        get user_session_export_path(user_session)

        expect(response).to have_http_status(:ok)
      end
    end

    context "when export does not exist" do
      it "returns :not_found" do
        get user_session_export_path(user_session)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
