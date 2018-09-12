FactoryBot.define do
  factory :arc do
    body { Faker::Lovecraft.sentence }
    story
    user
  end
end