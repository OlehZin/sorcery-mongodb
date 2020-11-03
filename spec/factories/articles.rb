FactoryBot.define do
  factory :article do
    title { Faker::Name.name}
    title_image { File.open( Rails.root + "spec/support/fixtures/images/#{rand(1..3)}.png") }
    body  { "test"}
    trait :published do
      published { true }
    end
    user
  end
end
