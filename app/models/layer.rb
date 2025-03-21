class Layer < ApplicationRecord
  belongs_to :user_session
  belongs_to :layerable, polymorphic: true

  validates :position, uniqueness: { scope: :user_session_id }
end
