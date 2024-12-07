class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :book_club_id
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
