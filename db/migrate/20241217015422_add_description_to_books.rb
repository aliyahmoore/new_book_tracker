class AddDescriptionToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :description, :text
  end
end
