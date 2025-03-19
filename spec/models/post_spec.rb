require 'rails_helper'

RSpec.describe Post, type: :model do
  it '正しいPOSTING' do
    post = build(:post)
    expect(post).to be_valid
  end

  it 'titleなしのPOSTING' do
    post = build(:post, title: nil)
    expect(post).not_to be_valid
  end

  it 'contentのPOSTING' do
    post = build(:post, content: nil)
    expect(post).not_to be_valid
  end


end
