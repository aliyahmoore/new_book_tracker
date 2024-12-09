class AddUserIdToBookClubs < ActiveRecord::Migration[7.2]
  def change
    add_reference :book_clubs, :user, foreign_key: true
  end
end
