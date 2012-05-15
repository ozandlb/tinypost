FactoryGirl.define do
  factory :user do
    name     "Royal Badass"
    email    "royalbadass@fakemail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end