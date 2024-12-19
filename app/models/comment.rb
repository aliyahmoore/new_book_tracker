class Comment < ApplicationRecord
  belongs_to :book

  validates :title, presence: true
  validates :body, presence: true
  validates :date, presence: true
end
