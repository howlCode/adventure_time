require 'rails_helper'

RSpec.describe Story, type: :model do

  it "is valid with valid attributes" do
    story = Story.create!(title: "test title", body: "test body")
  end

  it "is not valid without a title and/or body" do
    story = Story.new(title: nil, body: nil)
    expect(story).to_not be_valid
  end

end
