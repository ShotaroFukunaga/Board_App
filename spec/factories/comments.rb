FactoryBot.define do
  factory :comment do
    user { nil }
    board { nil }
    body { "MyString" }
  end
end
