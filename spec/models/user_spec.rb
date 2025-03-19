require 'rails_helper'

#RSpec.describe : 테스트 그룹을 정의
#tyep: :model => 모델 테스트임을 명시 
RSpec.describe User, type: :model do
  it '正しい会員登録' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'EMAILは必ずある事' do
    #build = 유저를 저장X, 그냥 반환
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'EMAILはかぶってはいけない' do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    expect(user).not_to be_valid    
  end


  it 'passwordは必ずあること' do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it 'passwordは必ず６文字以上であること' do
    user = build(:user, password: "12345")
    expect(user).not_to be_valid
  end

  it 'nameは必ずあること' do
    user = build(:user, name: nil)
    expect(user).not_to be_valid
  end
end