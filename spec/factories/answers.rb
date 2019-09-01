FactoryBot.define do
  factory :answer do
    question
    user
    body { "MyAnswer" }

    trait :invalid do
      body { nil }
    end
  end
end
