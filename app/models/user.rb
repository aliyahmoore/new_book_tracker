class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
    has_many :books
    has_many :book_clubs
    has_many :notes

    validates :username, presence: true, uniqueness: true
end
