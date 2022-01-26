FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "john-doe#{n}@example.com" }
    sequence(:username) { |n| "john-doe#{n}" }
    password { 'secure-password-123' }
    role { 'buyer' }
  end
end
