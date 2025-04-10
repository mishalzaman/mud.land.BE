RSpec.describe UserSession, type: :model do
  let!(:user_session) { UserSession.create! }
  let!(:gradient_layer_1) { GradientNoiseLayer.create!(name: "testA", blend_mode: "add") }
  let!(:gradient_layer_2) { GradientNoiseLayer.create!(name: "testB", blend_mode: "add") }

  before do
    user_session.layers.create!(layerable: gradient_layer_1, position: 1)
    user_session.layers.create!(layerable: gradient_layer_2, position: 2)
  end

  it "creates an id for user_session" do
    expect(user_session.id).not_to be_nil
  end

  context "when handling layers" do
    it "returns a list of procedural layers including GradientNoiseLayer instances" do
      expect(user_session.procedural_layers).to contain_exactly(gradient_layer_1, gradient_layer_2)
    end

    it "returns a list of layers in ascending order by position" do
      user_session.layers.create!(layerable: GradientNoiseLayer.create!(name: "testC", blend_mode: "add"), position: 3)
      user_session.layers.create!(layerable: GradientNoiseLayer.create!(name: "testD", blend_mode: "add"), position: 4)

      expect(user_session.layers.order(:position).pluck(:position)).to eq [1, 2, 3, 4]
    end

    it "returns an error when position is not unique within the same user_session" do
      gradient_noise_layer = GradientNoiseLayer.create!(name: "testE", blend_mode: "add")

      expect {
        user_session.layers.create!(layerable: gradient_noise_layer, position: 1)
      }.to raise_error(ActiveRecord::RecordInvalid, /Position has already been taken/)
    end

    it "destroys associated layers when user_session is deleted" do
      expect { user_session.destroy }.to change { Layer.count }.by(-2)
    end
  
    it "does not leave orphaned layers after user_session is destroyed" do
      user_session.destroy
      expect(Layer.exists?(gradient_layer_1.id)).to be_falsey
      expect(Layer.exists?(gradient_layer_2.id)).to be_falsey
    end
  end
end
