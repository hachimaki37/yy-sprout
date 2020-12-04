FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "sprout#{n}" }
    sequence(:email) { |n| "sprout#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end

  factory :admin_user, class: User do
    sequence(:nickname) { |n| "sprout#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
end