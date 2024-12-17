class Book < ApplicationRecord
  belongs_to :user
  belongs_to :book_club, optional: true
  attribute :image_link, :string
  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :google_id, presence: true, uniqueness: true
end
