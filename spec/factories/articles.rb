FactoryBot.define do
  factory :article do
    title { Faker::Name.name}
    body  { "test"}
    user
  end
end
