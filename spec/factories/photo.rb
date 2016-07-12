FactoryGirl.define do
  factory :photo do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }

    factory :photo_with_file do
      image { File.open("#{Rails.root}/spec/support/ror.png") }
    end
  end
end
