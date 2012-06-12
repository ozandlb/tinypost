FactoryGirl.define do
  factory :user do
    sequence(:name)   { |n| "Person #{n}" }
    sequence(:email)   { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end #factory :admin do
  end #factory :user do

  factory :micropost do
    content "Lorem ipsum"
    user
  end #micropost


end #FactoryGirl.define do

