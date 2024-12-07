class BookClub < ApplicationRecord
  belongs_to :user
  has_many :books

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
