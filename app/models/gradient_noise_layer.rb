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
end
