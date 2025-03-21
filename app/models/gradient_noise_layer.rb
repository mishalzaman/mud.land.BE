class GradientNoiseLayer < ApplicationRecord
  has_one :layer, as: :layerable, dependent: :destroy

  validates :name, presence: true
  validates :blend_mode, presence: true
  validates :opacity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :octaves, presence: true, numericality: { only_integer: true }
  validates :seed, presence: true, numericality: { only_integer: true }
  validates :offset_x, presence: true, numericality: { only_integer: true }
  validates :offset_y, presence: true, numericality: { only_integer: true }
  validates :scale_height, presence: true, numericality: { greater_than: 0 }
  validates :scale_width, presence: true, numericality: { greater_than: 0 }

  def self.defaults
    {
      simplex: {
        name: "simplex",
        blend_mode: "add",
        opacity: 1.0,
        octaves: 4,
        seed: rand(1..10_000),
        offset_x: 0,
        offset_y: 0,
        scale_height: 0.2,
        scale_width: 0.7
      }
    }
  end

  def self.defaults_for(key)
    defaults[key.to_sym]
  end
end
