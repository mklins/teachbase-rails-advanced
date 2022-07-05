FactoryBot.define do
  factory :answer do
    question
    body { "MyText" }
  end

  factory :invalid_answer, class: "Answer" do
    question
    title { nil }
    body { nil }
  end
end
