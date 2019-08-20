FactoryBot.define do
  factory :answer do
    question
    body { "MyAnswer" }

    trait :invalid do
      body { nil }
    end
  end
end
