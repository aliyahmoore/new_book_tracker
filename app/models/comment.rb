class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
