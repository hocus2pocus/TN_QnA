FactoryBot.define do
  factory :answer do
    question
    association :author, factory: :user
    body { "MyAnswer" }

    trait :invalid do
      body { nil }
    end
  end
end
