require 'rails_helper'

RSpec.describe Export, type: :model do
  let!(:user_session) { UserSession.create! }
  let!(:export) { Export.create!(user_session: user_session) }

  it "creates an id for export" do
    expect(export.id).not_to be_nil
  end

  it "returns the export model from the session" do
    expect(user_session.export).to eq export
  end
end
