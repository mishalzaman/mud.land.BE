require 'rails_helper'

RSpec.describe Water, type: :model do
  let!(:user_session) { UserSession.create! }
  let!(:water) { Water.create!(user_session: user_session) }

  it "creates an id for water" do
    expect(water.id).not_to be_nil
  end

  it "returns the water model from the session" do
    expect(user_session.water).to eq water
  end
end
