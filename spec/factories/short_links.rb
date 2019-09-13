FactoryBot.define do
  factory :short_link do
    encoded_id { Faker::Lorem.unique.characters(20) }
    sequence :long_link do |n|
      "https://www.google.com/#{n}"
    end

    sequence :user_id do |n|
      n
    end
  end
end
