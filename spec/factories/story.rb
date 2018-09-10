FactoryBot.define do
  factory :story do
    title { Faker::Name.name }
    body { Faker::Name.name }
    user
  end
end