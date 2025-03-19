require 'rails_helper'

RSpec.describe "Posts API", type: :request do
  let!(:user) {create(:user, email: "test@naver.com", password: "password", name: "test")}
  let!(:tag) {create(:tag)}
  let!(:existing_post) {create(:post, user: user, tag: tag)}

  before(:each) do
    sign_in user
  end


  it "正しいPOSTING" do
    post_params = {
      post: {
        title: "test",
        content: "test",
        tag_id: tag.id,
      }
    }

    self.post "/posts", params: post_params
    expect(response).to have_http_status(:created)    
  end

  it 'POSTINGリストの確認' do
    get "/posts" 

    body = JSON.parse(response.body)
    
    expect(body[0]["title"]).to eq(existing_post.title)
  end

  it '特定のPOSTINGを持ってくる' do
    get "/posts/"+existing_post.id.to_s

    body = JSON.parse(response.body)
    
    expect(body["title"]).to eq(existing_post.title)
  end

  it 'POSTINGの修正' do
    post_params = {
      post: {
        title: "new_test",
        content: "test",
        tag_id: tag.id,
      }
    }

    patch "/posts/"+existing_post.id.to_s, params: post_params

    body = JSON.parse(response.body)
    expect(body["post"]["title"]).to eq("new_test")

  end

  it 'POSTINGの削除' do
    delete "/posts/"+existing_post.id.to_s

    expect(response).to have_http_status(:ok)
  end


end
