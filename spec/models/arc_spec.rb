require 'rails_helper'

RSpec.describe Arc, type: :model do
  
  let(:user) {User.create!(nickname: 'testing', email: 'test@example.com', password: 'testing123')}
  let(:story) {Story.create!(title: 'testing', body: 'stuff', user: user)}

  it "is valid with valid attributes" do
    arc = Arc.create!(body: 'testing', story: story, user: user)
    expect(arc).to be_valid
  end

  it "is not valid without a body" do
    bad_arc = Arc.new(body: nil, story: story, user: user)
    expect(bad_arc).to_not be_valid
  end
  
end
