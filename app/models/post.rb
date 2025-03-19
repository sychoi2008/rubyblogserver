class Post < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  validates :title, presence: true
  validates :content, presence: true
end
