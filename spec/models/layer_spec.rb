RSpec.describe Layer, type: :model do
  let!(:user_session) { UserSession.create! }
  let!(:gradient_noise_layer) { GradientNoiseLayer.create!(name: "test", blend_mode: "add") }
  let!(:layer) do
    Layer.create!(
      layerable: gradient_noise_layer,
      user_session: user_session,
      position: 1
    )
  end

  it "creates a layer successfully" do
    expect(layer).to be_valid
  end

  it "returns error when position is not unique within the same user_session" do
    expect {
      Layer.create!(
        layerable: gradient_noise_layer,
        user_session: user_session,
        position: 1
      )
    }.to raise_error(ActiveRecord::RecordInvalid, /Position has already been taken/)
  end

  it "allows the same position in different user sessions" do
    another_session = UserSession.create!

    expect {
      Layer.create!(
        layerable: gradient_noise_layer,
        user_session: another_session, 
        position: 1
      )
    }.not_to raise_error
  end

  it "deletes layers when the user_session is destroyed" do
    expect { user_session.destroy }.to change { Layer.count }.by(-1)
  end

  it "requires a session" do
    layer_without_session = Layer.new(layerable: gradient_noise_layer, position: 2)
    expect(layer_without_session).not_to be_valid
    expect(layer_without_session.errors[:user_session]).to include("must exist")
  end

  it "requires a layerable object" do
    layer_without_layerable = Layer.new(user_session: user_session, position: 2)
    expect(layer_without_layerable).not_to be_valid
    expect(layer_without_layerable.errors[:layerable]).to include("must exist")
  end
end
