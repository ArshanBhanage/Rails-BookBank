class CreateMybooks < ActiveRecord::Migration[6.1]
  def change
    create_table :mybooks do |t|
      t.string :title
      t.string :year
      t.string :price

      t.timestamps
    end
  end
end
