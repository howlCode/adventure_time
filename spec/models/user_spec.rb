require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "should be valid with valid attributes" do
    user = User.create!(nickname: 'testing', email: 'test@example.com', password: "testing123")
    expect(user).to be_valid
  end
  
end
