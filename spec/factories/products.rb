FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    association :user
    amount_available { 5 }
    cost { 10 }
  end
end
