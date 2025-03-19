require 'rails_helper'

RSpec.describe "Tags API", type: :request do
  let!(:user) {create(:user, email: "test@naver.com", password: "password", name: "test")}
  let!(:tag) {create(:tag, name: "test_tag")}

  before(:each) do
    sign_in user
  end


  it "Tagリストの確認" do
    get "/tags"

    body = JSON.parse(response.body)
    expect(body[0]["name"]).to eq("test_tag")

    
  end

end