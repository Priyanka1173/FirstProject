require_relative '../../features/support/bucket.rb'

FactoryGirl.define do
  factory :admin_user do

    trait :main do
      username 'admin'
      password 'admin'
    end

    factory :main_user, traits: [:main]

  end
end
