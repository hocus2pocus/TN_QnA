FactoryBot.define do
  factory :question do
    association :author, factory: :user
    title { "MyString" }
    body { "MyText" }
  end

  trait :invalid do
    title { nil }
  end
end
