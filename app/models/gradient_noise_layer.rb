class GradientNoiseLayer < ApplicationRecord
  has_one :layer, as: :layerable, dependent: :destroy
end
