class Book < ApplicationRecord
  belongs_to :user
  belongs_to :book_club, optional: true

  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
end
