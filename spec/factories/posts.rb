FactoryBot.define do
  factory :post do
    title{"test post title"}
    content { "test post content"}
    
    # create(:post) 했을 때 user도 자동 생성하고 user_id가 들어감 
    association :user
    association :tag
  end
end