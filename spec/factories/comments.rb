FactoryBot.define do
  factory :comment do
    user_id { 1 }
    image_id { 1 }
    text { "MyString" }
  end
end
