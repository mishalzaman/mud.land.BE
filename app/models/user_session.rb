class UserSession < ApplicationRecord
  has_many :layers, -> { order(position: :asc) }, dependent: :destroy
  has_many :gradient_noise_layers, through: :layers, source: :layerable, source_type: "GradientNoiseLayer"
  has_one :export, dependent: :destroy
  has_one :water, dependent: :destroy

  def procedural_layers
    layers.includes(:layerable).map(&:layerable)
  end
end
