FactoryGirl.define do
  factory :photo do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
