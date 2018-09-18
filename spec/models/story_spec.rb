require 'rails_helper'

RSpec.describe Story, type: :model do

  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    story = Story.create!(title: "test title", body: "test body", user: user)
    expect(story).to be_valid
  end

  it "is not valid without a title and/or body" do
    story = Story.new(title: nil, body: nil, user: user)
    expect(story).to_not be_valid
  end

  it "is not valid without a user" do
    story = Story.new(title: "test title", body: "test body", user: nil)
    expect(story).to_not be_valid
  end
  
end
