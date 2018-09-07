FactoryBot.define do
  factory :story do
    title { "A testing story" }
    body { "Once upon a test" }
    user
  end
end