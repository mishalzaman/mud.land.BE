require 'rails_helper'

RSpec.describe Albedo, type: :model do
  let!(:user_session) { UserSession.create! }
  let!(:albedo) { Albedo.create!(user_session: user_session) }

  it "creates an id for export" do
    expect(albedo.id).not_to be_nil
  end

  it "returns the export model from the session" do
    expect(user_session.albedo).to eq albedo
  end
end
