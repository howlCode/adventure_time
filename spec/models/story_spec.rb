require 'rails_helper'

RSpec.describe Story, type: :model do
  it "should be required to have a title and a body" do
    story = Story.create!
  end
end
