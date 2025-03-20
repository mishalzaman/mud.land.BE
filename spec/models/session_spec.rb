RSpec.describe Session, type: :model do
  let(:session) { Session.create! }
  let(:gradient_layer_1) { GradientNoiseLayer.create!(name: "testA", blend_mode: "add") }
  let(:gradient_layer_2) { GradientNoiseLayer.create!(name: "testB", blend_mode: "add") }

  before do
    session.layers.create!(layerable: gradient_layer_1, position: 1)
    session.layers.create!(layerable: gradient_layer_2, position: 2)
  end

  it "creates an id for session" do
    expect(session.id).not_to be_nil
  end

  context "when handling layers" do
    it "returns a GradientNoiseLayer layer" do
      expect(session.procedural_layers).to contain_exactly(gradient_layer_1, gradient_layer_2)
    end

    it "returns a list of layers in order" do
      session.layers.create!(
        layerable: GradientNoiseLayer.create!(name: "testC", blend_mode: "add"),
        position: 3
      )
      session.layers.create!(
        layerable: GradientNoiseLayer.create!(name: "testD", blend_mode: "add"),
        position: 4
      )

      expect(session.layers[0].position).to eq 1
      expect(session.layers[1].position).to eq 2
      expect(session.layers[2].position).to eq 3
      expect(session.layers[3].position).to eq 4
    end

    it "returns an error when position is not unique" do
      gradient_noise_layer = GradientNoiseLayer.create!(name: "testE", blend_mode: "add")
  
      expect {
        session.layers.create!(layerable: gradient_noise_layer, position: 1)
      }.to raise_error(ActiveRecord::RecordInvalid, /Position has already been taken/)
    end
  end
end
