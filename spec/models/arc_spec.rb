require 'rails_helper'
require "#{Rails.root}/lib/tasks/inscribe.rb"

RSpec.describe Arc, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  include Inscribe

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

  it "after #inscribe it is a winner" do
    arc = Arc.create!(body: "test", user: user, story: story)
    arc2 = Arc.create!(body: "test", user: user, story: story)
    arc.expiry = DateTime.yesterday.in_time_zone(Time.zone)
    arc2.expiry = DateTime.yesterday.in_time_zone(Time.zone)
    arc.upvote_by user
    arc2.downvote_by user
    arcs = [arc, arc2]
    inscribe(arcs)
    expect(arc.inscribed).to be_truthy
  end

  it "after #inscribe it is a loser" do
    arc = Arc.create!(body: "test", user: user, story: story)
    arc2 = Arc.create!(body: "test", user: user, story: story)
    arc.expiry = DateTime.yesterday.in_time_zone(Time.zone)
    arc2.expiry = DateTime.yesterday.in_time_zone(Time.zone)
    arc.downvote_by user
    arc2.upvote_by user
    arcs = [arc, arc2]
    inscribe(arcs)
    expect(arc.inscribed).to be_falsey
  end

end
