FactoryGirl.define do
  sequence :email do |n|
    "user.#{n}@domain.tld"
  end

  factory :identity do
    email
    provider "developer"
    sequence(:uid)      { |n| "johnlocke-#{n}" }
    sequence(:username) { |n| "johnlocke-#{n}" }
    sequence(:name)     { |n| "John Locke-#{n}" }

    trait :admin do
      sequence(:uid) { |n| "adminlocke-#{n}" }
      name "Admin Locke"
    end
  end
end
