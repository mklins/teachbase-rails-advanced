FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.sentence }
    question
  end

  factory :invalid_answer, class: "Answer" do
    title { nil }
    body { nil }
    question
  end
end
