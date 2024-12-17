class Book < ApplicationRecord
  belongs_to :user
  belongs_to :book_club, optional: true
  attribute :google_id, :string
  attribute :image_url, :string
  attribute :description, :text
  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :status, presence: true
  validates :google_id, presence: true, uniqueness: true
end
