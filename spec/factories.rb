FactoryGirl.define do
  factory :user do
    first_name "First"
    last_name "Last"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "jessica"
    password_confirmation "jessica"
  end

  factory :todo_list do
    title "Todo List"
    association :user
  end
end
