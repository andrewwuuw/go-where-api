FactoryBot.define do
  factory :user do
    pwd = Faker::Internet.password
    email { Faker::Internet.email }
    password { pwd }
    password_confirmation { pwd }
  end
end