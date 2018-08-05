require 'rails_helper'

RSpec.describe Story, type: :model do

  let(:user) {User.create!(email: 'test@example.com', password: 'testing123')}

  it "is valid with valid attributes" do
    story = Story.create!(title: "test title", body: "test body", user: user)
    expect(story).to be_valid
  end

  it "is not valid without a title and/or body" do
    story = Story.new(title: nil, body: nil, user: nil)
    expect(story).to_not be_valid
  end

end
