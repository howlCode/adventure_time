require 'rails_helper'

RSpec.describe Arc, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  let(:user) { create(:user) }
  let(:story) { create(:story) }

  it "is valid with valid attributes" do
    arc = Arc.create!(body: "test", user: user, story: story)
    expect(arc).to be_valid
  end

  it "is not valid without a body" do
    arc = Arc.new(body: nil, user: user, story: story)
    expect(arc).to_not be_valid
  end

  it "is not valid without a user" do
    arc = Arc.new(body: nil, user: nil, story: story)
    expect(arc).to_not be_valid
  end
  
  it "is not valid without a story" do
    arc = Arc.new(body: nil, user: user, story: nil)
    expect(arc).to_not be_valid
  end

  it "is voteable" do
    arc = Arc.create!(body: "test", user: user, story: story)
    arc.upvote_by user
    expect(user.voted_for? arc).to be_truthy
  end

  it "is not expired before 24hrs" do
    arc = Arc.create!(body: "test", user: user, story: story)
    expect(arc.expired).to be_falsey
  end

  it "is expired after 24hrs" do
    arc = Arc.create!(body: "test", user: user, story: story)
    fake_time = arc.created_at.advance(days: 1.1)
    travel_to fake_time
    expect(arc.expired).to be_truthy
  end

end
