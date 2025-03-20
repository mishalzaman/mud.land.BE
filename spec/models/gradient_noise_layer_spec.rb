require 'rails_helper'

RSpec.describe GradientNoiseLayer, type: :model do
  let!(:gradient_noise_layer) do
    GradientNoiseLayer.create!(
      name: "Test Noise",
      blend_mode: "add",
      opacity: 0.8,
      octaves: 8,
      seed: 5678,
      offset_x: 5,
      offset_y: 10,
      scale_height: 0.25,
      scale_width: 0.35
    )
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(gradient_noise_layer).to be_valid
    end

    it "requires a name" do
      gradient_noise_layer.name = nil
      expect(gradient_noise_layer).not_to be_valid
      expect(gradient_noise_layer.errors[:name]).to include("can't be blank")
    end

    it "requires a blend_mode" do
      gradient_noise_layer.blend_mode = nil
      expect(gradient_noise_layer).not_to be_valid
      expect(gradient_noise_layer.errors[:blend_mode]).to include("can't be blank")
    end

    it "requires opacity to be between 0 and 1" do
      gradient_noise_layer.opacity = 1.5
      expect(gradient_noise_layer).not_to be_valid
      expect(gradient_noise_layer.errors[:opacity]).to include("must be less than or equal to 1")

      gradient_noise_layer.opacity = -0.5
      expect(gradient_noise_layer).not_to be_valid
      expect(gradient_noise_layer.errors[:opacity]).to include("must be greater than or equal to 0")
    end

    it "requires octaves to be an integer" do
      gradient_noise_layer.octaves = "invalid"
      expect(gradient_noise_layer).not_to be_valid
      expect(gradient_noise_layer.errors[:octaves]).to include("is not a number")
    end

    it "requires seed to be an integer" do
      gradient_noise_layer.seed = "random"
      expect(gradient_noise_layer).not_to be_valid
      expect(gradient_noise_layer.errors[:seed]).to include("is not a number")
    end
  end

  context "associations" do
    let!(:session) { Session.create! }
    let!(:layer) { session.layers.create!(layerable: gradient_noise_layer, position: 1) }

    it "can have an associated layer" do
      expect(gradient_noise_layer.layer).to eq(layer)
    end

    it "destroys the associated layer when deleted" do
      expect { gradient_noise_layer.destroy }.to change { Layer.count }.by(-1)
    end
  end
end
