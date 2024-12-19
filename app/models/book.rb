class Book < ApplicationRecord
  belongs_to :user
  belongs_to :book_club, optional: true

  has_many :comments, dependent: :destroy

  attribute :google_id, :string
  attribute :image_url, :string
  attribute :description, :text

  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :status, presence: true
  validates :google_id, uniqueness: true, allow_nil: true
end
