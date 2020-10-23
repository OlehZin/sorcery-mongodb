FactoryBot.define do
  factory :article do
    title { Faker::Name.name}
    body  { "test"}
    trait :published do
      published { true }
    end
    user
  end
end
