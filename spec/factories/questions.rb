# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "QuestionTitle"
    body "QuestionBody"
    user nil
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
    user nil
  end
end
