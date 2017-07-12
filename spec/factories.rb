FactoryGirl.define do
  factory :user do
    provider "github"
    sequence :uid do |n|
      "12345#{n}"
    end
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    username Faker::Internet.user_name
  end

  factory :question do
    title Faker::Lorem.characters(40)
    description Faker::Lorem.characters(150)
  end

  factory :answer do
    sequence :description do |n|
      "#{Faker::Lorem.characters(50)}#{n}"
    end
    question
  end
end
