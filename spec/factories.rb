FactoryBot.define do

  factory :user do
    name { "Anything" }
    email {"Anything@gmail.com"}
    password {"somepassword"}
  end

  factory :random_user, class: User do
    name { Faker::Name.name }
    email {Faker::Internet.email}
    password {"password"}
  end

  factory :doctor do
    name { "Anything" }
    position { "Anything" }
    img { "http://someimage.jpg" }
  end

  factory :appointment do
    start_time { Time.new(2021, 01, 01, 16, 0, 0) }
    end_time { Time.new(2021, 01, 01, 16, 10, 0) }
    association :user_id, factory: :user
    association :doctor_id, factory: :doctor
  end
end