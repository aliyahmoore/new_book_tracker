class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :genre
      t.string :title
      t.string :author
      t.text :notes
      t.date :start_date
      t.date :end_date
      t.integer :book_club_id
      t.string :status

      t.timestamps
    end
  end
end
