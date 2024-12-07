class UsersController < ApplicationController
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  has_many :book_clubs, dependent: :destroy
  has_many :books, through: :book_clubs
  has_many :notes, dependent: :destroy

  validates :username, presence: true
end
