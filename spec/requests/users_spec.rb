require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:user) {create(:user, email: "test@naver.com", password: "password", name: "test")}


  it "正しい会員登録" do
    user_params = {
      user: {
        email: "signup@naver.com",
        password: "password",
        name: "test"
      }
    }

    post "/users", params: user_params
    body = JSON.parse(response.body)
    
    expect(response).to have_http_status(:ok)
    expect(body["data"]["name"]).to eq("test")
    
  end

  it 'EMAILなしの会員登録' do
    user_params = {
      user: {
        password: "password",
        name: "test"
      }
    }

    post "/users", params: user_params
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it '名前なしの会員登録' do
    user_params = {
      user: {
        email: "test@naver.com",
        password: "password",
      }
    }

    post "/users", params: user_params
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'passwordなしの会員登録' do
    user_params = {
      user: {
        email: "test@naver.com",
        password: "password",
      }
    }

    post "/users", params: user_params
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it '正しいログイン' do
    user_params = {
      user: {
        email: "test@naver.com",
        password: "password",
      }
    }

    post "/users/sign_in", params: user_params
    body = JSON.parse(response.body)

    expect(response).to have_http_status(:ok)
    expect(body["message"]).to eq("로그인 성공")
  end

  it 'EMAILやpasswordが間違った場合' do
    user_params = {
      user: {
        email: "test@naver.com",
        password: "password11",
      }
    }

    post "/users/sign_in", params: user_params
    body = JSON.parse(response.body)

    expect(response).to have_http_status(:unauthorized)
    expect(body["message"]).to eq("이메일이나 비밀번호가 올바르지 않습니다.")
  end

  it '正しいログアウト' do
    sign_in user

    delete "/users/sign_out"
    body = JSON.parse(response.body)

    expect(response).to have_http_status(:ok)
    expect(body["message"]).to eq('로그아웃 성공')
  end
end

