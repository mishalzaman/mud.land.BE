require 'rails_helper'

RSpec.describe "Layers", type: :request do
  let(:user_session) { UserSession.create! }
  let(:layerable) { GradientNoiseLayer.create!(**GradientNoiseLayer.defaults[:simplex]) }

  describe "GET /user_sessions/:user_session_id/layers" do
    it "returns all layers for the user session" do
      Layer.create!(user_session: user_session, layerable: layerable, position: 0)
      Layer.create!(user_session: user_session, layerable: layerable.dup, position: 1)

      get "/user_sessions/#{user_session.id}/layers"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /user_sessions/:user_session_id/layers" do
    it "creates a layer and returns it" do
      layer = Layer.create!(user_session: user_session, layerable: layerable, position: 0)
      allow(LayerCreator).to receive(:create_for).and_return(layer)

      post "/user_sessions/#{user_session.id}/layers", params: {
        procedural_layer: {
          type: "Gradient",
          variant: "Perlin"
        }
      }

      expect(response).to have_http_status(:created)
    end

    it "returns error for invalid input" do
      allow(LayerCreator).to receive(:create_for).and_return({ error: "Invalid type", code: :invalid_type })

      post "/user_sessions/#{user_session.id}/layers", params: {
        procedural_layer: {
          type: "Invalid",
          variant: "Perlin"
        }
      }

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)["error"]).to eq("Invalid type")
    end
  end

  describe "PATCH /user_sessions/:user_session_id/layers/:id" do
    it "updates the layer and returns it" do
      layer = Layer.create!(user_session: user_session, layerable: layerable, position: 0)
      updated_data = layer.as_json.merge("position" => 5)

      allow(LayerUpdater).to receive(:update_for).and_return(updated_data)

      patch "/user_sessions/#{user_session.id}/layers/#{layer.id}", params: {
        data: { position: 5 }
      }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["position"]).to eq(5)
    end

    it "returns error when update fails" do
      layer = Layer.create!(user_session: user_session, layerable: layerable, position: 0)
      allow(LayerUpdater).to receive(:update_for).and_return(nil)

      patch "/user_sessions/#{user_session.id}/layers/#{layer.id}", params: {
        data: { position: -1 }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq("Update failed or layer not found")
    end
  end

  describe "DELETE /user_sessions/:user_session_id/layers/:id" do
    it "deletes the layer and shifts remaining layers" do
      layer1 = Layer.create!(user_session: user_session, layerable: layerable, position: 0)
      layer2 = Layer.create!(user_session: user_session, layerable: layerable.dup, position: 1)

      delete "/user_sessions/#{user_session.id}/layers/#{layer1.id}"

      expect(response).to have_http_status(:no_content)
      expect(Layer.find_by(id: layer1.id)).to be_nil
      expect(layer2.reload.position).to eq(0)
    end

    it "returns not found if layer does not exist" do
      delete "/user_sessions/#{user_session.id}/layers/9999"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("Layer not found")
    end
  end
end
