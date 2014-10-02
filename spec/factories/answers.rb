# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :answer do
    body "MyText"
    question nil
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question nil
  end
end
