require 'rails_helper'

RSpec.describe Weathering, type: :model do
  let!(:user_session) { UserSession.create! }
  let!(:weathering) { Weathering.create!(user_session: user_session) }

  it "creates an id for weathering" do
    expect(weathering.id).not_to be_nil
  end

  it "returns the weathering model from the session" do
    expect(user_session.weathering).to eq weathering
  end
end
