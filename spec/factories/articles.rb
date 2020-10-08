FactoryBot.define do
  factory :article do
    title { Faker::Name.name}
    body { "test"}
  end
end
