FactoryBot.define do
  factory :profile do
    first_name   {Faker::Name.first_name}
    last_name    {Faker::Name.last_name}
    nickname     {Faker::FunnyName.name}
    avatar       {Faker::Avatar.image}
    phone        {Faker::PhoneNumber.cell_phone}
    gender       {[0, 1, 2].sample}
    description  {Faker::FamousLastWords.last_words}
    device_type  {Faker::Device.platform}
    device_token {Faker::Device.serial}
  end
end