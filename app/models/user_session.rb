class UserSession < ApplicationRecord
  has_many :layers, -> { order(position: :asc) }, dependent: :destroy
  has_many :gradient_noise_layers, through: :layers, source: :layerable, source_type: "GradientNoiseLayer"

  def procedural_layers
    layers.includes(:layerable).map(&:layerable)
  end
end
