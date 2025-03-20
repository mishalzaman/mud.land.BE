class Layer < ApplicationRecord
  belongs_to :session
  belongs_to :layerable, polymorphic: true

  validates :position, uniqueness: { scope: :session_id }
end
