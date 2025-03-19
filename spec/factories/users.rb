FactoryBot.define do
  factory :user do
    # 중복 에러 방지를 위해 sequence 사용. 
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password"}
    name { "홍길동" }
  end
end