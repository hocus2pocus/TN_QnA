FactoryBot.define do
  factory :question do
    user
    title { "MyString" }
    body { "MyText" }
  end

  trait :invalid do
    title { nil }
  end
end
