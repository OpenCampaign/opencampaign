FactoryGirl.define do

  factory :user do
    identities { Array.wrap(FactoryGirl.create(:identity, user: self)) }

    trait :no_identities do
      identities []
    end

    trait :multiple_identities do
      identities {
        Array(2..3).sample.times.map do
          FactoryGirl.create(:identity, user: self)
        end
      }
    end

    factory :admin do
      identities { Array.wrap(FactoryGirl.create(:identity, :admin)) }
      after(:create) { |user| user.add_role :admin }
    end
  end

end
