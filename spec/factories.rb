FactoryGirl.define do
  factory :user do
    first_name "Jessica"
    last_name "Edwards"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "jessica"
    password_confirmation "jessica"
  end

  factory :todo_list do
    title "Groceries"
    association :user
  end
end
